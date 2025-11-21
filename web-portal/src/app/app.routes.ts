import { Routes } from '@angular/router';
import { Login } from './login/login';
import { Dashboard } from './dashboard/dashboard';
import { UserList } from './user-list/user-list';
import { MainLayout } from './components/main-layout/main-layout';
import { ShopItems } from './admin/shop-items/shop-items';
import { Orders } from './admin/orders/orders';
import { Users } from './admin/users/users';

export const routes: Routes = [
  { path: '', redirectTo: '/login', pathMatch: 'full' },
  { path: 'login', component: Login },
  {
    path: '',
    component: MainLayout,
    children: [
      { path: 'dashboard', component: Dashboard },
      { path: 'user-list/:userId', component: UserList },
      { path: 'admin/shop-items', component: ShopItems },
      { path: 'admin/orders', component: Orders },
      { path: 'admin/users', component: Users },
    ]
  },
  { path: '**', redirectTo: '/login' }
];
