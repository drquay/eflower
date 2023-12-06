import { User } from './interface';

export const admin: User = {
  id: 1,
  name: 'admin 222',
  email: 'admin@123456',
  avatar: './assets/images/admin.png',
};

export const guest: User = {
  name: 'unknown',
  email: 'unknown',
  avatar: './assets/images/avatar-default.jpg',
};
