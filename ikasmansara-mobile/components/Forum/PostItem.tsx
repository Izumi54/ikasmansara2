import React from 'react';
import { View, Text, StyleSheet, TouchableOpacity, Image } from 'react-native';
import { Heart, MessageCircle, Share2 } from 'lucide-react-native';

interface Post {
    id: string;
    user: string;
    content: string;
    time: string;
    likes: number;
    comments: number;
    isLiked: boolean;
}

interface PostItemProps {
    post: Post;
    onToggleLove: (postId: string) => void;
    onPressLoveCount: (postId: string) => void;
    onPressComment: (postId: string) => void;
}

const PostItem = ({ post, onToggleLove, onPressLoveCount, onPressComment }: PostItemProps) => {
    return (
        <View style={styles.container}>
            <View style={styles.header}>
                <View style={styles.avatarPlaceholder}>
                    <Text style={styles.avatarText}>{post.user.charAt(0).toUpperCase()}</Text>
                </View>
                <View>
                    <Text style={styles.userName}>{post.user}</Text>
                    <Text style={styles.time}>{post.time}</Text>
                </View>
            </View>

            <Text style={styles.content}>{post.content}</Text>

            <View style={styles.actions}>
                <View style={styles.actionGroup}>
                    <TouchableOpacity onPress={() => onToggleLove(post.id)}>
                        <Heart
                            size={24}
                            color={post.isLiked ? '#EF4444' : '#6B7280'}
                            fill={post.isLiked ? '#EF4444' : 'transparent'}
                        />
                    </TouchableOpacity>
                    <TouchableOpacity onPress={() => onPressLoveCount(post.id)}>
                        <Text style={styles.actionText}>{post.likes} Suka</Text>
                    </TouchableOpacity>
                </View>

                <View style={styles.actionGroup}>
                    <TouchableOpacity onPress={() => onPressComment(post.id)}>
                        <MessageCircle size={24} color="#6B7280" />
                    </TouchableOpacity>
                    <TouchableOpacity onPress={() => onPressComment(post.id)}>
                        <Text style={styles.actionText}>{post.comments} Komentar</Text>
                    </TouchableOpacity>
                </View>

                <TouchableOpacity style={styles.actionGroup}>
                    <Share2 size={24} color="#6B7280" />
                </TouchableOpacity>
            </View>
        </View>
    );
};

const styles = StyleSheet.create({
    container: {
        backgroundColor: 'white',
        padding: 16,
        marginBottom: 8,
        borderBottomWidth: 1,
        borderBottomColor: '#F3F4F6',
    },
    header: {
        flexDirection: 'row',
        alignItems: 'center',
        marginBottom: 12,
    },
    avatarPlaceholder: {
        width: 40,
        height: 40,
        borderRadius: 20,
        backgroundColor: '#E5E7EB',
        justifyContent: 'center',
        alignItems: 'center',
        marginRight: 12,
    },
    avatarText: {
        fontSize: 16,
        fontWeight: 'bold',
        color: '#374151',
    },
    userName: {
        fontWeight: 'bold',
        fontSize: 16,
        color: '#111827',
    },
    time: {
        fontSize: 12,
        color: '#6B7280',
    },
    content: {
        fontSize: 16,
        color: '#374151',
        lineHeight: 24,
        marginBottom: 16,
    },
    actions: {
        flexDirection: 'row',
        justifyContent: 'space-between',
        borderTopWidth: 1,
        borderTopColor: '#F3F4F6',
        paddingTop: 12,
    },
    actionGroup: {
        flexDirection: 'row',
        alignItems: 'center',
        gap: 8,
    },
    actionText: {
        fontSize: 14,
        color: '#6B7280',
    },
});

export default PostItem;
