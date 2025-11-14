import { Routes } from '@angular/router';

export const routes: Routes = [
  {
    path: '',
    loadChildren: () => import('./tabs/tabs.routes').then((m) => m.routes),
  },
  {
    path: 'auth',
    loadComponent: () => import('./auth/auth.page').then( m => m.AuthPage)
  },
  { path: '', redirectTo: 'auth', pathMatch: 'full' }, // 默认进入 auth
  { path: '**', redirectTo: 'auth' },
];
