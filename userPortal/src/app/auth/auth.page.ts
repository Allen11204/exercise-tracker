import { Component } from '@angular/core';
import { IonicModule, ToastController } from '@ionic/angular';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { HttpClient } from '@angular/common/http';
import { Router } from '@angular/router';

@Component({
  standalone: true,
  selector: 'app-auth',
  templateUrl: './auth.page.html',
  imports: [IonicModule, CommonModule, FormsModule],
})
export class AuthPage {
  mode: 'login' | 'register' = 'login';
  username = '';
  password = '';

  constructor(
    private http: HttpClient,
    private toast: ToastController,
    private router: Router
  ) {}

  async onSubmit() {
    const url = this.mode === 'login'
      ? 'http://localhost:8080/api/auth/login'
      : 'http://localhost:8080/api/auth/register';

    this.http.post<{id: number, username: string}>(url, { username: this.username, password: this.password })
      .subscribe({
        next: async (res) => {
          // 保存用户名和用户 ID 到 localStorage
          localStorage.setItem('currentUsername', res.username);
          localStorage.setItem('currentUserId', res.id.toString());

          (await this.toast.create({
            message: `${this.mode === 'login' ? 'Login' : 'Registration'} successful!`,
            duration: 1200,
            color: 'success',
          })).present();

          // ✅ 登录/注册成功后跳到 Tab1
          this.router.navigateByUrl('/tabs/tab1');
        },
        error: async () => {
          (await this.toast.create({
            message: 'Request failed. Please check backend or parameters.',
            duration: 1800,
            color: 'danger',
          })).present();
        }
      });
  }
}
