import { Component, OnInit, ViewChild, ElementRef, AfterViewInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { HttpClient } from '@angular/common/http';
import {
  IonHeader, IonToolbar, IonTitle, IonContent, IonCard, IonCardHeader,
  IonCardTitle, IonCardContent, IonItem, IonLabel, IonInput, IonButton,
  IonList, IonIcon, IonSelect, IonSelectOption, IonText, IonSpinner, IonListHeader
} from '@ionic/angular/standalone';
import { addIcons } from 'ionicons';
import {
  searchOutline, closeOutline, timeOutline, calendarOutline, homeOutline,
  sunnyOutline, fitnessOutline, bicycle, walk, water, barbell, ellipse, globeOutline,
  barChartOutline
} from 'ionicons/icons';
import { TimezoneService } from '../services/timezone.service';
import { Chart, registerables } from 'chart.js';

// Register Chart.js components
Chart.register(...registerables);

@Component({
  selector: 'app-tab2',
  templateUrl: 'tab2.page.html',
  styleUrls: ['tab2.page.scss'],
  standalone: true,
  imports: [
    CommonModule,
    FormsModule,
    IonHeader, IonToolbar, IonTitle, IonContent, IonCard, IonCardHeader,
    IonCardTitle, IonCardContent, IonItem, IonLabel, IonInput, IonButton,
    IonList, IonIcon, IonSelect, IonSelectOption, IonText, IonSpinner, IonListHeader
  ]
})
export class Tab2Page implements OnInit, AfterViewInit {
  @ViewChild('exerciseChart', { static: false }) exerciseChartRef!: ElementRef<HTMLCanvasElement>;
  private chart: Chart | null = null;

  // Past 7 days report data
  past7DaysData: { date: string; duration: number }[] = [];
  loadingReport: boolean = false;

  // All exercise history
  exercises: any[] = [];
  loadingHistory: boolean = false;

  // User info
  userId: number = 0; // Will be loaded from localStorage

  // Current viewing timezone (from TimezoneService, shared with Tab1)
  selectedTimezone: string = '';

  // Chart data for display
  chartLabels: string[] = [];
  chartData: number[] = [];

  private apiUrl = 'http://localhost:8080/api/exercises';

  constructor(
    private http: HttpClient,
    private timezoneService: TimezoneService
  ) {
    // Register icons
    addIcons({
      'search-outline': searchOutline,
      'close-outline': closeOutline,
      'time-outline': timeOutline,
      'calendar-outline': calendarOutline,
      'home-outline': homeOutline,
      'sunny-outline': sunnyOutline,
      'fitness-outline': fitnessOutline,
      'bicycle': bicycle,
      'walk': walk,
      'water': water,
      'barbell': barbell,
      'ellipse': ellipse,
      'globe-outline': globeOutline,
      'bar-chart-outline': barChartOutline
    });
  }

  ngAfterViewInit() {
    // Chart will be created after data is loaded
  }

  ngOnInit() {
    // Load userId from localStorage
    const userIdStr = localStorage.getItem('currentUserId');
    if (userIdStr) {
      this.userId = parseInt(userIdStr, 10);
    }

    // Load user's timezone preference
    this.selectedTimezone = this.timezoneService.getTimezone();
    // Load all exercise history first, then generate report
    this.loadExerciseHistory();
  }

  ionViewWillEnter() {
    // Refresh timezone when entering the view (in case it was changed in Tab1)
    this.selectedTimezone = this.timezoneService.getTimezone();
    // Reload exercise history (which will trigger report generation)
    this.loadExerciseHistory();
  }

  /**
   * Get date string in YYYY-MM-DD format
   */
  getDateString(date: Date): string {
    return date.getFullYear() + '-' +
           String(date.getMonth() + 1).padStart(2, '0') + '-' +
           String(date.getDate()).padStart(2, '0');
  }

  /**
   * Get past 7 days dates starting from the day before lastSyncDate
   * Example: if lastSyncDate is 11-12, return dates from 11-5 to 11-11
   */
  getPast7DaysDates(): string[] {
    const lastSyncDate = localStorage.getItem('lastSyncDate');
    let endDate: Date;

    if (lastSyncDate) {
      // Start from the day BEFORE lastSyncDate
      endDate = new Date(lastSyncDate);
      endDate.setDate(endDate.getDate() - 1);
    } else {
      // If no lastSyncDate, use yesterday
      endDate = new Date();
      endDate.setDate(endDate.getDate() - 1);
    }

    // Generate 7 dates ending at endDate
    const dates: string[] = [];
    for (let i = 0; i < 7; i++) {
      const date = new Date(endDate);
      date.setDate(date.getDate() - 6 + i);
      dates.push(this.getDateString(date));
    }

    return dates;
  }

  /**
   * Load past 7 days exercise report
   * This will be called after loadExerciseHistory completes
   */
  loadPast7DaysReport() {
    if (!this.exercises || this.exercises.length === 0) {
      this.past7DaysData = [];
      this.chartLabels = [];
      this.chartData = [];
      this.loadingReport = false;
      return;
    }

    // Get lastSyncDate from localStorage
    const lastSyncDate = localStorage.getItem('lastSyncDate');
    if (!lastSyncDate) {
      this.past7DaysData = [];
      this.chartLabels = [];
      this.chartData = [];
      this.loadingReport = false;
      return;
    }

    // Calculate the date range: from (lastSyncDate - 7 days) to (lastSyncDate - 1 day)
    // Parse lastSyncDate parts to create date in local timezone
    const [year, month, day] = lastSyncDate.split('-').map(Number);
    const endDate = new Date(year, month - 1, day);
    endDate.setDate(endDate.getDate() - 1); // Day before lastSyncDate

    const startDate = new Date(endDate);
    startDate.setDate(startDate.getDate() - 6); // 6 days before endDate (total 7 days)

    console.log('Chart date range:', this.getDateString(startDate), 'to', this.getDateString(endDate));

    // Generate 7 dates
    const dates: string[] = [];
    for (let i = 0; i < 7; i++) {
      const date = new Date(startDate);
      date.setDate(startDate.getDate() + i);
      dates.push(this.getDateString(date));
    }

    // Group exercises by date and sum duration
    const durationByDate = new Map<string, number>();
    dates.forEach(date => durationByDate.set(date, 0));

    this.exercises.forEach((ex: any) => {
      // Convert occurredAt to date string
      // The backend returns ZonedDateTime which JavaScript parses automatically
      const date = new Date(ex.occurredAt);
      const dateStr = this.getDateString(date);

      if (durationByDate.has(dateStr)) {
        durationByDate.set(dateStr, durationByDate.get(dateStr)! + ex.durationMinutes);
      }
    });

    // Prepare chart data
    this.past7DaysData = dates.map(date => ({
      date,
      duration: durationByDate.get(date) || 0
    }));

    this.chartLabels = dates.map(date => {
      const [, m, d] = date.split('-').map(Number);
      return `${m}/${d}`;
    });
    this.chartData = this.past7DaysData.map(d => d.duration);

    console.log('Past 7 days data:', this.past7DaysData);

    this.loadingReport = false;

    // Render chart after data is loaded
    setTimeout(() => this.renderChart(), 100);
  }

  /**
   * Load all exercise history
   */
  loadExerciseHistory() {
    this.loadingHistory = true;
    this.loadingReport = true;

    // Build query parameters to get all exercises
    const params: any = {
      userId: this.userId,
      page: 0,
      size: 100
    };

    this.http.get<any>(this.apiUrl, { params }).subscribe({
      next: (response) => {
        this.exercises = response.content || [];
        this.loadingHistory = false;
        console.log('Loaded exercise history:', this.exercises);

        // After loading history, generate the report
        this.loadPast7DaysReport();
      },
      error: (error) => {
        console.error('Failed to load exercise history:', error);
        this.exercises = [];
        this.loadingHistory = false;
        this.loadingReport = false;
      }
    });
  }

  /**
   * Format date for display in selected viewing timezone
   */
  formatDate(dateString: string): string {
    if (!dateString) return 'N/A';
    try {
      // Parse the ISO string from backend (UTC)
      const date = new Date(dateString);

      // Format in the selected viewing timezone
      const formatter = new Intl.DateTimeFormat('en-US', {
        timeZone: this.selectedTimezone,
        year: 'numeric',
        month: '2-digit',
        day: '2-digit',
        hour: '2-digit',
        minute: '2-digit',
        second: '2-digit',
        hour12: false
      });

      return formatter.format(date);
    } catch (error) {
      console.error('Error formatting date:', error);
      return dateString;
    }
  }

  /**
   * Get timezone abbreviation for display
   */
  getTimezoneAbbreviation(): string {
    try {
      const date = new Date();
      const formatter = new Intl.DateTimeFormat('en-US', {
        timeZone: this.selectedTimezone,
        timeZoneName: 'short'
      });
      const parts = formatter.formatToParts(date);
      const tzPart = parts.find(part => part.type === 'timeZoneName');
      return tzPart ? tzPart.value : this.selectedTimezone;
    } catch (error) {
      return this.selectedTimezone;
    }
  }

  /**
   * Get icon for exercise type
   */
  getExerciseIcon(type: string): string {
    const icons: { [key: string]: string } = {
      'RUN': 'walk',
      'WALK': 'walk',
      'CYCLE': 'bicycle',
      'SWIM': 'water',
      'GYM': 'barbell',
      'OTHER': 'ellipse'
    };
    return icons[type] || 'fitness-outline';
  }

  /**
   * Render the line chart
   */
  renderChart() {
    if (!this.exerciseChartRef || this.chartData.length === 0) {
      return;
    }

    // Destroy existing chart if any
    if (this.chart) {
      this.chart.destroy();
    }

    const ctx = this.exerciseChartRef.nativeElement.getContext('2d');
    if (!ctx) return;

    // Calculate Y-axis max value based on data (round up to nearest 30)
    const maxDuration = Math.max(...this.chartData, 0);
    const yAxisMax = Math.ceil(maxDuration / 30) * 30 + 30; // Round up to nearest 30 and add padding

    this.chart = new Chart(ctx, {
      type: 'line',
      data: {
        labels: this.chartLabels,
        datasets: [{
          label: 'Exercise Duration (minutes)',
          data: this.chartData,
          borderColor: 'rgb(75, 192, 192)',
          backgroundColor: 'rgba(75, 192, 192, 0.2)',
          tension: 0.3,
          fill: true,
          pointRadius: 6,
          pointHoverRadius: 8,
          pointBackgroundColor: 'rgb(75, 192, 192)',
          pointBorderColor: '#fff',
          pointBorderWidth: 2
        }]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
          legend: {
            display: true,
            position: 'top'
          },
          title: {
            display: true,
            text: 'Past 7 Days Exercise Activity'
          }
        },
        scales: {
          y: {
            beginAtZero: true,
            max: yAxisMax > 0 ? yAxisMax : 60,
            ticks: {
              stepSize: 30,
              callback: function(value) {
                return value + ' min';
              }
            },
            title: {
              display: true,
              text: 'Duration (minutes)'
            }
          },
          x: {
            title: {
              display: true,
              text: 'Date'
            }
          }
        }
      }
    });
  }
}
