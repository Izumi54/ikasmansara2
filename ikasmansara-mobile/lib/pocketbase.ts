import PocketBase from 'pocketbase';

// Replace with your actual PocketBase URL
// For Android Emulator use 10.0.2.2 instead of localhost
export const pb = new PocketBase('http://127.0.0.1:8090');

// Optional: Disable auto-cancellation
pb.autoCancellation(false);
