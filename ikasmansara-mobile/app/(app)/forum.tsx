import React, { useRef, useState, useCallback } from 'react';
import { View, FlatList, StyleSheet, SafeAreaView } from 'react-native';
import { Stack } from 'expo-router';
import BottomSheet from '@gorhom/bottom-sheet';
import PostItem from '../../components/Forum/PostItem';
import LoveBottomSheet from '../../components/Forum/LoveBottomSheet';
import CommentBottomSheet from '../../components/Forum/CommentBottomSheet';

// Dummy Data
const DUMMY_POSTS = [
    {
        id: '1',
        user: 'Ahmad Fauzi',
        content: 'Halo semua! Ada yang tahu kapan reuni akbar tahun ini diadakan?',
        time: '2 jam yang lalu',
        likes: 12,
        comments: 5,
        isLiked: false,
    },
    {
        id: '2',
        user: 'Siti Aminah',
        content: 'Baru saja mampir ke sekolah, ternyata banyak banget perubahannya ya. Kangen masa-masa SMA.',
        time: '5 jam yang lalu',
        likes: 45,
        comments: 12,
        isLiked: true,
    },
    {
        id: '3',
        user: 'Budi Santoso',
        content: 'Info lowongan kerja untuk alumni yang berminat di bidang IT, bisa japri saya ya.',
        time: '1 hari yang lalu',
        likes: 8,
        comments: 2,
        isLiked: false,
    },
];

const DUMMY_USERS = [
    { id: 'u1', name: 'Rina Wati' },
    { id: 'u2', name: 'Doni Pratama' },
    { id: 'u3', name: 'Eka Saputra' },
    { id: 'u4', name: 'Fani Rahma' },
    { id: 'u5', name: 'Gilang Ramadhan' },
];

const DUMMY_COMMENTS = [
    { id: 'c1', user: 'Rina Wati', text: 'Wah seru nih, kabari ya infonya!', timestamp: '1 jam lalu' },
    { id: 'c2', user: 'Doni Pratama', text: 'Setuju, kangen banget sama kantin bu ijah.', timestamp: '30 menit lalu' },
];

export default function ForumScreen() {
    const [posts, setPosts] = useState(DUMMY_POSTS);
    const [selectedPostId, setSelectedPostId] = useState<string | null>(null);

    // Refs
    const loveSheetRef = useRef<BottomSheet>(null);
    const commentSheetRef = useRef<BottomSheet>(null);

    // Handlers
    const handleToggleLove = useCallback((postId: string) => {
        setPosts(currentPosts =>
            currentPosts.map(post => {
                if (post.id === postId) {
                    const newIsLiked = !post.isLiked;
                    return {
                        ...post,
                        isLiked: newIsLiked,
                        likes: newIsLiked ? post.likes + 1 : post.likes - 1,
                    };
                }
                return post;
            })
        );
    }, []);

    const handlePressLoveCount = useCallback((postId: string) => {
        setSelectedPostId(postId);
        loveSheetRef.current?.expand();
    }, []);

    const handlePressComment = useCallback((postId: string) => {
        setSelectedPostId(postId);
        commentSheetRef.current?.expand();
    }, []);

    const handleAddComment = useCallback((text: string) => {
        console.log('New comment:', text, 'for post:', selectedPostId);
        // In a real app, you would add the comment to the backend here
        commentSheetRef.current?.close();
    }, [selectedPostId]);

    return (
        <SafeAreaView style={styles.container}>
            <Stack.Screen options={{ title: 'Forum Alumni', headerShadowVisible: false }} />

            <FlatList
                data={posts}
                keyExtractor={(item) => item.id}
                renderItem={({ item }) => (
                    <PostItem
                        post={item}
                        onToggleLove={handleToggleLove}
                        onPressLoveCount={handlePressLoveCount}
                        onPressComment={handlePressComment}
                    />
                )}
                contentContainerStyle={styles.listContent}
            />

            <LoveBottomSheet
                bottomSheetRef={loveSheetRef}
                users={DUMMY_USERS}
            />

            <CommentBottomSheet
                bottomSheetRef={commentSheetRef}
                comments={DUMMY_COMMENTS}
                onAddComment={handleAddComment}
            />
        </SafeAreaView>
    );
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: '#F9FAFB',
    },
    listContent: {
        paddingBottom: 20,
    },
});
