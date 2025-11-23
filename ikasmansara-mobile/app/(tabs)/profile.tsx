import { View, Text, TouchableOpacity } from 'react-native';
import { useAuth } from '../../context/AuthContext';
import { Ionicons } from '@expo/vector-icons';

export default function Profile() {
    const { logout, user } = useAuth();

    return (
        <View className="flex-1 items-center justify-center bg-white p-6">
            <View className="w-24 h-24 bg-gray-200 rounded-full mb-4 items-center justify-center">
                <Ionicons name="person" size={48} color="gray" />
            </View>
            <Text className="text-2xl font-bold mb-2">{user?.name || 'User'}</Text>
            <Text className="text-gray-500 mb-8">{user?.email}</Text>

            <TouchableOpacity
                className="bg-red-500 px-8 py-3 rounded-full"
                onPress={logout}
            >
                <Text className="text-white font-bold">Keluar</Text>
            </TouchableOpacity>
        </View>
    );
}
