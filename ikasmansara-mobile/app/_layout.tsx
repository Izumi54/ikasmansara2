import { Slot } from 'expo-router';
import { GestureHandlerRootView } from 'react-native-gesture-handler';
import { AuthProvider } from '../context/AuthContext';
import "../global.css";
import { StatusBar } from 'expo-status-bar';

export default function RootLayout() {
    return (
        <GestureHandlerRootView style={{ flex: 1 }}>
            <AuthProvider>
                <StatusBar style="dark" />
                <Slot />
            </AuthProvider>
        </GestureHandlerRootView>
    );
}
