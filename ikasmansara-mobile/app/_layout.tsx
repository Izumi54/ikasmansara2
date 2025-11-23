import { Stack, useRouter, useSegments } from 'expo-router';
import "../global.css";
import { AuthProvider, useAuth } from '../context/AuthContext';
import { useEffect } from 'react';
import { View, ActivityIndicator } from 'react-native';

const StackLayout = () => {
    const { user, isLoading } = useAuth();
    const segments = useSegments();
    const router = useRouter();

    useEffect(() => {
        if (isLoading) return;

        const inAuthGroup = segments[0] === '(auth)';

        if (!user && !inAuthGroup) {
            // Redirect to the login page if not signed in
            router.replace('/(auth)/login');
        } else if (user && inAuthGroup) {
            // Redirect to the home page if signed in
            router.replace('/(tabs)');
        }
    }, [user, segments, isLoading]);

    if (isLoading) {
        return (
            <View style={{ flex: 1, justifyContent: 'center', alignItems: 'center' }}>
                <ActivityIndicator size="large" />
            </View>
        );
    }

    return (
        <Stack screenOptions={{ headerShown: false }}>
            <Stack.Screen name="(tabs)" />
            <Stack.Screen name="(auth)" />
        </Stack>
    );
};

export default function Layout() {
    return (
        <AuthProvider>
            <StackLayout />
        </AuthProvider>
    );
}
