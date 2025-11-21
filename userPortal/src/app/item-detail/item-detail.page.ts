import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ActivatedRoute, Router } from '@angular/router';
import {
  IonHeader, IonToolbar, IonTitle, IonContent, IonCard, IonCardHeader,
  IonCardTitle, IonCardContent, IonButton, IonIcon, IonBadge, IonButtons,
  IonBackButton, IonSpinner, IonText, IonTextarea, IonItem, IonLabel,
  IonList, AlertController, IonRefresher, IonRefresherContent
} from '@ionic/angular/standalone';
import { addIcons } from 'ionicons';
import { heartOutline, heart, chatbubbleOutline, addCircle, arrowBack, sendOutline } from 'ionicons/icons';
import { ShopService, ShopItem, Comment } from '../services/shop.service';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-item-detail',
  templateUrl: './item-detail.page.html',
  styleUrls: ['./item-detail.page.scss'],
  standalone: true,
  imports: [
    CommonModule,
    FormsModule,
    IonHeader, IonToolbar, IonTitle, IonContent, IonCard, IonCardHeader,
    IonCardTitle, IonCardContent, IonButton, IonIcon, IonBadge, IonButtons,
    IonBackButton, IonSpinner, IonText, IonTextarea, IonItem, IonLabel,
    IonList, IonRefresher, IonRefresherContent
  ]
})
export class ItemDetailPage implements OnInit {
  item: ShopItem | null = null;
  loading: boolean = true;
  itemId: number = 0;
  userId: number = 1;
  userPoints: number = 0;

  // Like/Comment functionality (from backend)
  isLiked: boolean = false;
  likeCount: number = 0;
  comments: Comment[] = [];
  newCommentText: string = '';

  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private shopService: ShopService,
    private alertController: AlertController
  ) {
    addIcons({
      'heart-outline': heartOutline,
      'heart': heart,
      'chatbubble-outline': chatbubbleOutline,
      'add-circle': addCircle,
      'arrow-back': arrowBack,
      'send-outline': sendOutline
    });
  }

  ngOnInit() {
    this.userId = parseInt(localStorage.getItem('currentUserId') || '1');
    this.itemId = parseInt(this.route.snapshot.paramMap.get('id') || '0');

    if (this.itemId) {
      this.loadItemDetail();
      this.loadUserProfile();
      this.loadLikeStatus();
      this.loadComments();
    }
  }

  loadItemDetail() {
    this.loading = true;
    this.shopService.getAvailableItems().subscribe({
      next: (items) => {
        this.item = items.find(i => i.id === this.itemId) || null;
        if (!this.item) {
          this.router.navigate(['/shop']);
        }
        this.loading = false;
      },
      error: (error) => {
        console.error('Failed to load item:', error);
        this.loading = false;
      }
    });
  }

  loadUserProfile() {
    this.shopService.getUserProfile(this.userId).subscribe({
      next: (profile) => {
        this.userPoints = profile.points;
      },
      error: (error) => {
        console.error('Failed to load user profile:', error);
      }
    });
  }

  loadLikeStatus() {
    this.shopService.getLikeStatus(this.itemId, this.userId).subscribe({
      next: (liked) => {
        this.isLiked = liked;
      },
      error: (error) => {
        console.error('Failed to load like status:', error);
      }
    });

    this.shopService.getLikeCount(this.itemId).subscribe({
      next: (count) => {
        this.likeCount = count;
      },
      error: (error) => {
        console.error('Failed to load like count:', error);
      }
    });
  }

  loadComments() {
    this.shopService.getComments(this.itemId).subscribe({
      next: (comments) => {
        this.comments = comments;
      },
      error: (error) => {
        console.error('Failed to load comments:', error);
      }
    });
  }

  toggleLike() {
    this.shopService.toggleLike(this.itemId, this.userId).subscribe({
      next: (liked) => {
        this.isLiked = liked;
        // Refresh like count
        this.shopService.getLikeCount(this.itemId).subscribe({
          next: (count) => {
            this.likeCount = count;
          }
        });
      },
      error: (error) => {
        console.error('Failed to toggle like:', error);
      }
    });
  }

  async addComment() {
    if (!this.newCommentText.trim()) {
      return;
    }

    this.shopService.addComment(this.itemId, this.userId, this.newCommentText.trim()).subscribe({
      next: async (comment) => {
        this.comments.unshift(comment);
        this.newCommentText = '';

        const alert = await this.alertController.create({
          header: 'Success',
          message: 'Comment added successfully!',
          buttons: ['OK']
        });
        await alert.present();
      },
      error: async (error) => {
        console.error('Failed to add comment:', error);
        const alert = await this.alertController.create({
          header: 'Error',
          message: 'Failed to add comment. Please try again.',
          buttons: ['OK']
        });
        await alert.present();
      }
    });
  }

  async addToCart(item: ShopItem) {
    if (item.stock <= 0) {
      const alert = await this.alertController.create({
        header: 'Out of Stock',
        message: 'This item is currently out of stock.',
        buttons: ['OK']
      });
      await alert.present();
      return;
    }

    this.shopService.addToCart(this.userId, item.id).subscribe({
      next: async () => {
        const alert = await this.alertController.create({
          header: 'Added to Cart',
          message: `${item.name} has been added to your cart!`,
          buttons: ['OK']
        });
        await alert.present();
      },
      error: async (error) => {
        const alert = await this.alertController.create({
          header: 'Error',
          message: error.error || 'Failed to add item to cart.',
          buttons: ['OK']
        });
        await alert.present();
      }
    });
  }

  canAfford(item: ShopItem): boolean {
    return this.userPoints >= item.pointsRequired;
  }

  getTimeAgo(timestamp: string | Date): string {
    const now = new Date();
    const diff = now.getTime() - new Date(timestamp).getTime();
    const minutes = Math.floor(diff / 60000);
    const hours = Math.floor(minutes / 60);
    const days = Math.floor(hours / 24);

    if (days > 0) return `${days} day${days > 1 ? 's' : ''} ago`;
    if (hours > 0) return `${hours} hour${hours > 1 ? 's' : ''} ago`;
    if (minutes > 0) return `${minutes} minute${minutes > 1 ? 's' : ''} ago`;
    return 'Just now';
  }

  handleRefresh(event: any) {
    this.loadItemDetail();
    this.loadUserProfile();
    this.loadLikeStatus();
    this.loadComments();
    setTimeout(() => {
      event.target.complete();
    }, 1000);
  }
}
