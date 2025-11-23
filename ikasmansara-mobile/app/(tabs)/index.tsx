import { View, Text, ScrollView, Image, TouchableOpacity } from 'react-native';
import { useAuth } from '../../context/AuthContext';
import { Ionicons } from '@expo/vector-icons';

export default function Home() {
    const { user } = useAuth();

    return (
        <ScrollView className="flex-1 bg-gray-50">
            {/* Header */}
            <View className="bg-white p-6 pb-4">
                <View className="flex-row justify-between items-center mb-4">
                    <View>
                        <Text className="text-gray-500 text-xs">Halo, Alumni!</Text>
                        <Text className="text-xl font-bold text-gray-800">{user?.name || 'User'}</Text>
                    </View>
                    <View className="w-10 h-10 bg-gray-200 rounded-full overflow-hidden items-center justify-center">
                        {/* Placeholder Avatar */}
                        <Ionicons name="person" size={24} color="gray" />
                    </View>
                </View>

                {/* E-KTA Card Preview */}
                <View className="bg-green-700 rounded-2xl p-5 shadow-lg relative overflow-hidden mb-6">
                    <View className="absolute -right-5 -bottom-5 opacity-10">
                        <Ionicons name="school" size={100} color="white" />
                    </View>
                    <View className="w-10 h-8 bg-white/20 rounded-md mb-4" />
                    <Text className="text-white text-lg font-bold tracking-widest">{user?.name?.toUpperCase() || 'NAMA ANGGOTA'}</Text>
                    <View className="flex-row justify-between mt-2">
                        <Text className="text-white/80 text-xs">ANGKATAN {user?.graduation_year || 'XXXX'}</Text>
                        <Text className="text-white/80 text-xs">NO: {user?.student_id_number || 'XXXX.XX.XX'}</Text>
                    </View>
                </View>

                {/* Quick Menu */}
                <View className="flex-row justify-between px-2">
                    <MenuIcon icon="cash-outline" label="Donasi" />
                    <MenuIcon icon="newspaper-outline" label="Berita" />
                    <MenuIcon icon="briefcase-outline" label="Loker" />
                    <MenuIcon icon="cart-outline" label="Market" />
                </View>
            </View>

            {/* Content Sections */}
            <View className="p-6">
                <Text className="text-lg font-bold mb-4 text-gray-800">Kabar SMANSARA</Text>
                <View className="bg-white p-4 rounded-xl shadow-sm border border-gray-100 mb-4">
                    <Text className="font-bold text-base mb-2">Reuni Akbar Angkatan 2000</Text>
                    <Text className="text-gray-500 text-sm">Persiapan reuni akbar sudah mencapai 80%...</Text>
                </View>
            </View>
        </ScrollView>
    );
}

const MenuIcon = ({ icon, label }: { icon: any, label: string }) => (
    <TouchableOpacity className="items-center">
        <View className="w-12 h-12 bg-green-50 rounded-2xl items-center justify-center mb-2">
            <Ionicons name={icon} size={24} color="#15803d" />
        </View>
        <Text className="text-xs font-medium text-gray-600">{label}</Text>
    </TouchableOpacity>
);
