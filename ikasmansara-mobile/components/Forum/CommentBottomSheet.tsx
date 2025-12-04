import React, { useMemo, useState } from 'react';
import { View, Text, StyleSheet, TouchableOpacity, KeyboardAvoidingView, Platform } from 'react-native';
import BottomSheet, { BottomSheetFlatList, BottomSheetBackdrop, BottomSheetTextInput, BottomSheetFooter } from '@gorhom/bottom-sheet';
import { Send } from 'lucide-react-native';

interface Comment {
    id: string;
    user: string;
    text: string;
    timestamp: string;
}

interface CommentBottomSheetProps {
    bottomSheetRef: React.RefObject<BottomSheet>;
    comments: Comment[];
    onAddComment: (text: string) => void;
}

const CommentBottomSheet = ({ bottomSheetRef, comments, onAddComment }: CommentBottomSheetProps) => {
    const snapPoints = useMemo(() => ['50%', '90%'], []);
    const [text, setText] = useState('');

    const handleSend = () => {
        if (text.trim()) {
            onAddComment(text);
            setText('');
        }
    };

    const renderItem = ({ item }: { item: Comment }) => (
        <View style={styles.commentItem}>
            <View style={styles.avatarPlaceholder}>
                <Text style={styles.avatarText}>{item.user.charAt(0).toUpperCase()}</Text>
            </View>
            <View style={styles.commentContent}>
                <View style={styles.commentHeader}>
                    <Text style={styles.userName}>{item.user}</Text>
                    <Text style={styles.timestamp}>{item.timestamp}</Text>
                </View>
                <Text style={styles.commentText}>{item.text}</Text>
            </View>
        </View>
    );

    const renderFooter = (props: any) => (
        <BottomSheetFooter {...props} bottomInset={0}>
            <View style={styles.footerContainer}>
                <BottomSheetTextInput
                    style={styles.input}
                    placeholder="Tulis komentar..."
                    value={text}
                    onChangeText={setText}
                />
                <TouchableOpacity onPress={handleSend} style={styles.sendButton}>
                    <Send size={20} color="white" />
                </TouchableOpacity>
            </View>
        </BottomSheetFooter>
    );

    return (
        <BottomSheet
            ref={bottomSheetRef}
            index={-1}
            snapPoints={snapPoints}
            enablePanDownToClose={true}
            keyboardBehavior="interactive"
            keyboardBlurBehavior="restore"
            android_keyboardInputMode="adjustResize"
            backdropComponent={(props) => (
                <BottomSheetBackdrop {...props} disappearsOnIndex={-1} appearsOnIndex={0} />
            )}
            footerComponent={renderFooter}
        >
            <View style={styles.contentContainer}>
                <Text style={styles.headerTitle}>Komentar</Text>
                <BottomSheetFlatList
                    data={comments}
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
    },
    headerTitle: {
        fontSize: 18,
        fontWeight: 'bold',
        marginBottom: 16,
        textAlign: 'center',
        paddingTop: 16,
    },
    listContent: {
        paddingHorizontal: 16,
        paddingBottom: 80, // Space for footer
    },
    commentItem: {
        flexDirection: 'row',
        marginBottom: 16,
    },
    avatarPlaceholder: {
        width: 32,
        height: 32,
        borderRadius: 16,
        backgroundColor: '#e0e0e0',
        justifyContent: 'center',
        alignItems: 'center',
        marginRight: 12,
    },
    avatarText: {
        fontSize: 14,
        fontWeight: 'bold',
        color: '#555',
    },
    commentContent: {
        flex: 1,
        backgroundColor: '#f9f9f9',
        padding: 12,
        borderRadius: 12,
        borderTopLeftRadius: 0,
    },
    commentHeader: {
        flexDirection: 'row',
        justifyContent: 'space-between',
        marginBottom: 4,
    },
    userName: {
        fontWeight: 'bold',
        fontSize: 14,
        color: '#333',
    },
    timestamp: {
        fontSize: 12,
        color: '#999',
    },
    commentText: {
        fontSize: 14,
        color: '#444',
        lineHeight: 20,
    },
    footerContainer: {
        flexDirection: 'row',
        alignItems: 'center',
        padding: 12,
        borderTopWidth: 1,
        borderTopColor: '#eee',
        backgroundColor: 'white',
    },
    input: {
        flex: 1,
        backgroundColor: '#f0f0f0',
        borderRadius: 20,
        paddingHorizontal: 16,
        paddingVertical: 8, // Reduced vertical padding
        marginRight: 12,
        fontSize: 16,
        height: 40, // Fixed height
    },
    sendButton: {
        backgroundColor: '#006A4E',
        width: 40,
        height: 40,
        borderRadius: 20,
        justifyContent: 'center',
        alignItems: 'center',
    },
});

export default CommentBottomSheet;
