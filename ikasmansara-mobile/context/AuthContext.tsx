import React, { createContext, useContext, useEffect, useState } from 'react';
import { pb } from '../lib/pocketbase';
import { AuthModel } from 'pocketbase';

interface AuthContextType {
    user: AuthModel | null;
    isLoading: boolean;
    login: (email: string, pass: string) => Promise<void>;
    logout: () => void;
}

const AuthContext = createContext<AuthContextType>({
    user: null,
    isLoading: true,
    login: async () => { },
    logout: () => { },
});

export const useAuth = () => useContext(AuthContext);

export const AuthProvider = ({ children }: { children: React.ReactNode }) => {
    const [user, setUser] = useState<AuthModel | null>(pb.authStore.model);
    const [isLoading, setIsLoading] = useState(true);

    useEffect(() => {
        // Check initial auth state
        setUser(pb.authStore.model);
        setIsLoading(false);

        // Listen to auth changes
        const unsubscribe = pb.authStore.onChange((token, model) => {
            setUser(model);
        });

        return () => {
            unsubscribe();
        };
    }, []);

    const login = async (email: string, pass: string) => {
        await pb.collection('users').authWithPassword(email, pass);
    };

    const logout = () => {
        pb.authStore.clear();
    };

    return (
        <AuthContext.Provider value={{ user, isLoading, login, logout }}>
            {children}
        </AuthContext.Provider>
    );
};
