import { View, Text, TextInput, TouchableOpacity, Alert, ScrollView } from 'react-native';
import { useState } from 'react';
import { pb } from '../../lib/pocketbase';
import { router } from 'expo-router';

export default function Register() {
    const [name, setName] = useState('');
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const [passwordConfirm, setPasswordConfirm] = useState('');
    const [loading, setLoading] = useState(false);

    const handleRegister = async () => {
        if (password !== passwordConfirm) {
            Alert.alert('Error', 'Password tidak sama');
            return;
        }
        setLoading(true);
        try {
            const data = {
                email,
                emailVisibility: true,
                password,
                passwordConfirm,
                name,
                role: 'public', // Default role, can be updated later
            };
            await pb.collection('users').create(data);
            Alert.alert('Sukses', 'Akun berhasil dibuat. Silakan login.');
            router.back();
        } catch (error: any) {
            Alert.alert('Error', error.message);
        } finally {
            setLoading(false);
        }
    };

    return (
        <ScrollView contentContainerStyle={{ flexGrow: 1, justifyContent: 'center', padding: 32 }} className="bg-white">
            <Text className="text-3xl font-bold mb-8 text-center text-green-700">Daftar</Text>
            <TextInput
                className="border border-gray-300 rounded-lg p-4 mb-4"
                placeholder="Nama Lengkap"
                value={name}
                onChangeText={setName}
            />
            <TextInput
                className="border border-gray-300 rounded-lg p-4 mb-4"
                placeholder="Email"
                value={email}
                onChangeText={setEmail}
                autoCapitalize="none"
            />
            <TextInput
                className="border border-gray-300 rounded-lg p-4 mb-4"
                placeholder="Password"
                value={password}
                onChangeText={setPassword}
                secureTextEntry
            />
            <TextInput
                className="border border-gray-300 rounded-lg p-4 mb-6"
                placeholder="Konfirmasi Password"
                value={passwordConfirm}
                onChangeText={setPasswordConfirm}
                secureTextEntry
            />
            <TouchableOpacity
                className="bg-green-600 p-4 rounded-lg items-center"
                onPress={handleRegister}
                disabled={loading}
            >
                <Text className="text-white font-bold text-lg">{loading ? 'Loading...' : 'Daftar'}</Text>
            </TouchableOpacity>
            <TouchableOpacity className="mt-4 items-center" onPress={() => router.back()}>
                <Text className="text-gray-500">Sudah punya akun? Masuk</Text>
            </TouchableOpacity>
        </ScrollView>
    );
}
