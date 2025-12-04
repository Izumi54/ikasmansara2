import React, { useMemo } from 'react';
import { View, Text, StyleSheet } from 'react-native';
import BottomSheet, { BottomSheetFlatList, BottomSheetBackdrop } from '@gorhom/bottom-sheet';

interface User {
    id: string;
    name: string;
    avatar?: string;
}

interface LoveBottomSheetProps {
    bottomSheetRef: React.RefObject<BottomSheet>;
    users: User[];
}

const LoveBottomSheet = ({ bottomSheetRef, users }: LoveBottomSheetProps) => {
    const snapPoints = useMemo(() => ['50%', '75%'], []);

    const renderItem = ({ item }: { item: User }) => (
        <View style={styles.userItem}>
            <View style={styles.avatarPlaceholder}>
                <Text style={styles.avatarText}>{item.name.charAt(0).toUpperCase()}</Text>
            </View>
            <Text style={styles.userName}>{item.name}</Text>
        </View>
    );

    return (
        <BottomSheet
            ref={bottomSheetRef}
            index={-1}
            snapPoints={snapPoints}
            enablePanDownToClose={true}
            backdropComponent={(props) => (
                <BottomSheetBackdrop {...props} disappearsOnIndex={-1} appearsOnIndex={0} />
            )}
        >
            <View style={styles.contentContainer}>
                <Text style={styles.headerTitle}>Disukai oleh</Text>
                <BottomSheetFlatList
                    data={users}
                    keyExtractor={(item) => item.id}
                    renderItem={renderItem}
                    contentContainerStyle={styles.listContent}
                />
            </View>
        </BottomSheet>
    );
};

const styles = StyleSheet.create({
    contentContainer: {
        flex: 1,
        padding: 16,
    },
    headerTitle: {
        fontSize: 18,
        fontWeight: 'bold',
        marginBottom: 16,
        textAlign: 'center',
    },
    listContent: {
        paddingBottom: 20,
    },
    userItem: {
        flexDirection: 'row',
        alignItems: 'center',
        paddingVertical: 12,
        borderBottomWidth: 1,
        borderBottomColor: '#f0f0f0',
    },
    avatarPlaceholder: {
        width: 40,
        height: 40,
        borderRadius: 20,
        backgroundColor: '#e0e0e0',
        justifyContent: 'center',
        alignItems: 'center',
        marginRight: 12,
    },
    avatarText: {
        fontSize: 16,
        fontWeight: 'bold',
        color: '#555',
    },
    userName: {
        fontSize: 16,
        color: '#333',
    },
});

export default LoveBottomSheet;
