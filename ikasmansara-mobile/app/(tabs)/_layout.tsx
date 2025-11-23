import { Tabs } from 'expo-router';
import { Ionicons } from '@expo/vector-icons';

export default function TabLayout() {
    return (
        <Tabs screenOptions={{ tabBarActiveTintColor: '#15803d' }}>
            <Tabs.Screen
                name="index"
                options={{
                    title: 'Home',
                    tabBarIcon: ({ color }) => <Ionicons name="home" size={24} color={color} />,
                    headerShown: false,
                }}
            />
            <Tabs.Screen
                name="directory"
                options={{
                    title: 'Direktori',
                    tabBarIcon: ({ color }) => <Ionicons name="people" size={24} color={color} />,
                }}
            />
            <Tabs.Screen
                name="market"
                options={{
                    title: 'Market',
                    tabBarIcon: ({ color }) => <Ionicons name="cart" size={24} color={color} />,
                }}
            />
            <Tabs.Screen
                name="profile"
                options={{
                    title: 'Profil',
                    tabBarIcon: ({ color }) => <Ionicons name="person" size={24} color={color} />,
                }}
            />
        </Tabs>
    );
}
