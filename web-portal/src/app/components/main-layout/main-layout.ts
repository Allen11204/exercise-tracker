import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';

@Component({
  selector: 'app-main-layout',
  imports: [CommonModule, RouterModule],
  templateUrl: './main-layout.html',
  styleUrl: './main-layout.scss',
})
export class MainLayout implements OnInit {
  currentUsername: string = 'Guest';

  ngOnInit() {
    // Get current username from localStorage
    const storedUsername = localStorage.getItem('username');
    if (storedUsername) {
      this.currentUsername = storedUsername;
      console.log('Logged in as:', storedUsername);
    } else {
      console.warn('No username found in localStorage. Please login again.');
      this.currentUsername = 'Guest';
    }
  }
}
