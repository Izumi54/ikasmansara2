import { View, Text, TextInput, TouchableOpacity, Alert } from 'react-native';
import { useState } from 'react';
import { useAuth } from '../../context/AuthContext';
import { Link, router } from 'expo-router';

export default function Login() {
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const { login } = useAuth();
    const [loading, setLoading] = useState(false);

    const handleLogin = async () => {
        setLoading(true);
        try {
            await login(email, password);
            router.replace('/(tabs)');
        } catch (error: any) {
            Alert.alert('Error', error.message);
        } finally {
            setLoading(false);
        }
    };

    return (
        <View className="flex-1 justify-center px-8 bg-white">
            <Text className="text-3xl font-bold mb-8 text-center text-green-700">Masuk</Text>
            <TextInput
                className="border border-gray-300 rounded-lg p-4 mb-4"
                placeholder="Email"
                value={email}
                onChangeText={setEmail}
                autoCapitalize="none"
            />
            <TextInput
                className="border border-gray-300 rounded-lg p-4 mb-6"
                placeholder="Password"
                value={password}
                onChangeText={setPassword}
                secureTextEntry
            />
            <TouchableOpacity
                className="bg-green-600 p-4 rounded-lg items-center"
                onPress={handleLogin}
                disabled={loading}
            >
                <Text className="text-white font-bold text-lg">{loading ? 'Loading...' : 'Masuk'}</Text>
            </TouchableOpacity>
            <Link href="/(auth)/register" asChild>
                <TouchableOpacity className="mt-4 items-center">
                    <Text className="text-gray-500">Belum punya akun? Daftar</Text>
                </TouchableOpacity>
            </Link>
        </View>
    );
}
