#!/bin/bash
# ==============================================================================
# 🚀 REACT HACKATHON FULL-STACK STARTER KIT SETUP SCRIPT
# ==============================================================================
# Tech Stack:
#  - React 19 + TypeScript + Vite
#  - Tailwind CSS + shadcn/ui Design System (Dark/Light Mode)
#  - Zustand State Management (Persist Storage)
#  - React Router v7 (Page & Sidebar Navigation)
#  - Shared Worker (Multi-Tab Realtime Synchronization)
#  - Service Worker (PWA & Offline Caching)
# ==============================================================================

set -e

# Terminal colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
BOLD='\033[1m'
NC='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEFAULT_TARGET="$SCRIPT_DIR"

# Kiểm tra nếu người dùng truyền tham số dòng lệnh $1
if [ -n "$1" ]; then
  RAW_PATH="$1"
else
  # Cho phép người dùng nhập path tương tác trong terminal
  echo -e "${YELLOW}${BOLD}Nhập đường dẫn thư mục dự án muốn tạo:${NC}"
  echo -e "👉 Nhấn ${CYAN}[Enter]${NC} để dùng mặc định: ${GREEN}${DEFAULT_TARGET}${NC}"
  read -p "Đường dẫn: " USER_INPUT_PATH
  RAW_PATH="${USER_INPUT_PATH:-$DEFAULT_TARGET}"
fi

# Xử lý ký tự ~ thành $HOME nếu có
RAW_PATH="${RAW_PATH/#\~/$HOME}"

# Tạo thư mục và lấy đường dẫn tuyệt đối
mkdir -p "$RAW_PATH"
TARGET_DIR="$(cd "$RAW_PATH" && pwd)"

echo -e "\n${CYAN}${BOLD}======================================================${NC}"
echo -e "${CYAN}${BOLD}🚀 KHỞI TẠO DỰ ÁN REACTJS HACKATHON STARTER KIT${NC}"
echo -e "${CYAN}${BOLD}======================================================${NC}"
echo -e "📁 Thư mục dự án: ${GREEN}${TARGET_DIR}${NC}\n"

cd "$TARGET_DIR"

# ------------------------------------------------------------------------------
# 1. Package Configuration
# ------------------------------------------------------------------------------
echo -e "${BLUE}📦 [1/8] Thiết lập package.json và cài đặt dependencies...${NC}"
cat << 'EOF' > package.json
{
  "name": "hackathon-react-starter",
  "private": true,
  "version": "1.0.0",
  "type": "module",
  "scripts": {
    "dev": "vite",
    "build": "tsc -b && vite build",
    "preview": "vite preview"
  },
  "dependencies": {
    "@radix-ui/react-avatar": "^1.1.3",
    "@radix-ui/react-dialog": "^1.1.6",
    "@radix-ui/react-dropdown-menu": "^2.1.6",
    "@radix-ui/react-separator": "^1.1.2",
    "@radix-ui/react-slot": "^1.1.2",
    "@radix-ui/react-tooltip": "^1.1.8",
    "class-variance-authority": "^0.7.1",
    "clsx": "^2.1.1",
    "lucide-react": "^0.475.0",
    "react": "^19.0.0",
    "react-dom": "^19.0.0",
    "react-router-dom": "^7.1.5",
    "tailwind-merge": "^3.0.1",
    "tailwindcss-animate": "^1.0.7",
    "zustand": "^5.0.3"
  },
  "devDependencies": {
    "@types/node": "^22.13.4",
    "@types/react": "^19.0.8",
    "@types/react-dom": "^19.0.3",
    "@vitejs/plugin-react": "^4.3.4",
    "autoprefixer": "^10.4.20",
    "postcss": "^8.5.2",
    "tailwindcss": "^3.4.17",
    "typescript": "^5.7.3",
    "vite": "^6.1.0"
  }
}
EOF

echo -e "${CYAN}⏳ Đang chạy npm install...${NC}"
npm install --silent

# ------------------------------------------------------------------------------
# 2. Config Files (Vite, TS, Tailwind, PostCSS, shadcn/ui)
# ------------------------------------------------------------------------------
echo -e "${BLUE}⚙️  [2/8] Tạo các file cấu hình hệ thống...${NC}"

# vite.config.ts
cat << 'EOF' > vite.config.ts
import path from "path";
import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";

export default defineConfig({
  plugins: [react()],
  resolve: {
    alias: {
      "@": path.resolve(__dirname, "./src"),
    },
  },
  worker: {
    format: "es",
  },
  server: {
    port: 3000,
    open: true,
  },
});
EOF

# tsconfig.json
cat << 'EOF' > tsconfig.json
{
  "files": [],
  "references": [
    { "path": "./tsconfig.app.json" },
    { "path": "./tsconfig.node.json" }
  ]
}
EOF

# tsconfig.app.json
cat << 'EOF' > tsconfig.app.json
{
  "compilerOptions": {
    "target": "ES2022",
    "useDefineForClassFields": true,
    "lib": ["ES2022", "DOM", "DOM.Iterable", "WebWorker"],
    "module": "ESNext",
    "skipLibCheck": true,
    "moduleResolution": "bundler",
    "allowImportingTsExtensions": true,
    "resolveJsonModule": true,
    "isolatedModules": true,
    "moduleDetection": "force",
    "noEmit": true,
    "jsx": "react-jsx",
    "strict": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "noFallthroughCasesInSwitch": true,
    "baseUrl": ".",
    "paths": {
      "@/*": ["./src/*"]
    }
  },
  "include": ["src"]
}
EOF

# tsconfig.node.json
cat << 'EOF' > tsconfig.node.json
{
  "compilerOptions": {
    "target": "ES2022",
    "lib": ["ES2022"],
    "module": "ESNext",
    "skipLibCheck": true,
    "moduleResolution": "bundler",
    "allowImportingTsExtensions": true,
    "isolatedModules": true,
    "moduleDetection": "force",
    "noEmit": true,
    "strict": true
  },
  "include": ["vite.config.ts"]
}
EOF

# tailwind.config.js
cat << 'EOF' > tailwind.config.js
/** @type {import('tailwindcss').Config} */
module.exports = {
  darkMode: ["class"],
  content: [
    "./index.html",
    "./src/**/*.{ts,tsx,js,jsx}",
  ],
  theme: {
    container: {
      center: true,
      padding: "2rem",
      screens: {
        "2xl": "1400px",
      },
    },
    extend: {
      colors: {
        border: "hsl(var(--border))",
        input: "hsl(var(--input))",
        ring: "hsl(var(--ring))",
        background: "hsl(var(--background))",
        foreground: "hsl(var(--foreground))",
        primary: {
          DEFAULT: "hsl(var(--primary))",
          foreground: "hsl(var(--primary-foreground))",
        },
        secondary: {
          DEFAULT: "hsl(var(--secondary))",
          foreground: "hsl(var(--secondary-foreground))",
        },
        destructive: {
          DEFAULT: "hsl(var(--destructive))",
          foreground: "hsl(var(--destructive-foreground))",
        },
        muted: {
          DEFAULT: "hsl(var(--muted))",
          foreground: "hsl(var(--muted-foreground))",
        },
        accent: {
          DEFAULT: "hsl(var(--accent))",
          foreground: "hsl(var(--accent-foreground))",
        },
        popover: {
          DEFAULT: "hsl(var(--popover))",
          foreground: "hsl(var(--popover-foreground))",
        },
        card: {
          DEFAULT: "hsl(var(--card))",
          foreground: "hsl(var(--card-foreground))",
        },
        sidebar: {
          DEFAULT: "hsl(var(--sidebar-background))",
          foreground: "hsl(var(--sidebar-foreground))",
          primary: "hsl(var(--sidebar-primary))",
          "primary-foreground": "hsl(var(--sidebar-primary-foreground))",
          accent: "hsl(var(--sidebar-accent))",
          "accent-foreground": "hsl(var(--sidebar-accent-foreground))",
          border: "hsl(var(--sidebar-border))",
          ring: "hsl(var(--sidebar-ring))",
        },
      },
      borderRadius: {
        lg: "var(--radius)",
        md: "calc(var(--radius) - 2px)",
        sm: "calc(var(--radius) - 4px)",
      },
    },
  },
  plugins: [require("tailwindcss-animate")],
}
EOF

# postcss.config.js
cat << 'EOF' > postcss.config.js
export default {
  plugins: {
    tailwindcss: {},
    autoprefixer: {},
  },
}
EOF

# components.json for shadcn
cat << 'EOF' > components.json
{
  "$schema": "https://ui.shadcn.com/schema.json",
  "style": "default",
  "rsc": false,
  "tsx": true,
  "tailwind": {
    "config": "tailwind.config.js",
    "css": "src/index.css",
    "baseColor": "slate",
    "cssVariables": true,
    "prefix": ""
  },
  "aliases": {
    "components": "@/components",
    "utils": "@/lib/utils",
    "ui": "@/components/ui",
    "lib": "@/lib",
    "hooks": "@/hooks"
  }
}
EOF

# index.html
cat << 'EOF' > index.html
<!doctype html>
<html lang="vi" class="dark">
  <head>
    <meta charset="UTF-8" />
    <link rel="icon" type="image/svg+xml" href="/vite.svg" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Hackathon Starter | React + TypeScript + Zustand + Workers</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
  </head>
  <body class="min-h-screen bg-background font-sans antialiased">
    <div id="root"></div>
    <script type="module" src="/src/main.tsx"></script>
  </body>
</html>
EOF

# ------------------------------------------------------------------------------
# 3. Folder Structure
# ------------------------------------------------------------------------------
echo -e "${BLUE}📂 [3/8] Tạo cấu trúc thư mục dự án...${NC}"
mkdir -p src/{assets,components/{common,layout,ui},hooks,lib,pages,routes,stores,types,workers}
mkdir -p public

# ------------------------------------------------------------------------------
# 4. Design System & CSS Variables
# ------------------------------------------------------------------------------
echo -e "${BLUE}🎨 [4/8] Thiết lập Design System & CSS Variables...${NC}"

# src/index.css
cat << 'EOF' > src/index.css
@tailwind base;
@tailwind components;
@tailwind utilities;

@layer base {
  :root {
    --background: 220 20% 97%;
    --foreground: 224 71% 4%;
    --card: 0 0% 100%;
    --card-foreground: 224 71% 4%;
    --popover: 0 0% 100%;
    --popover-foreground: 224 71% 4%;
    --primary: 238 84% 60%;
    --primary-foreground: 210 40% 98%;
    --secondary: 220 14% 96%;
    --secondary-foreground: 220.9 39.3% 11%;
    --muted: 220 14% 96%;
    --muted-foreground: 220 9% 46%;
    --accent: 220 14% 94%;
    --accent-foreground: 220.9 39.3% 11%;
    --destructive: 0 84.2% 60.2%;
    --destructive-foreground: 210 40% 98%;
    --border: 220 13% 91%;
    --input: 220 13% 91%;
    --ring: 238 84% 60%;
    --radius: 0.75rem;

    --sidebar-background: 0 0% 100%;
    --sidebar-foreground: 240 5.3% 26.1%;
    --sidebar-primary: 240 5.9% 10%;
    --sidebar-primary-foreground: 0 0% 98%;
    --sidebar-accent: 240 4.8% 95.9%;
    --sidebar-accent-foreground: 240 5.9% 10%;
    --sidebar-border: 220 13% 91%;
    --sidebar-ring: 217.2 91.2% 59.8%;
  }

  .dark {
    --background: 224 25% 6%;
    --foreground: 210 40% 98%;
    --card: 224 25% 9%;
    --card-foreground: 210 40% 98%;
    --popover: 224 25% 9%;
    --popover-foreground: 210 40% 98%;
    --primary: 238 84% 67%;
    --primary-foreground: 224 71% 4%;
    --secondary: 224 20% 14%;
    --secondary-foreground: 210 40% 98%;
    --muted: 224 20% 14%;
    --muted-foreground: 215 16% 65%;
    --accent: 224 20% 16%;
    --accent-foreground: 210 40% 98%;
    --destructive: 0 62.8% 30.6%;
    --destructive-foreground: 210 40% 98%;
    --border: 224 20% 16%;
    --input: 224 20% 16%;
    --ring: 238 84% 67%;

    --sidebar-background: 224 25% 8%;
    --sidebar-foreground: 240 4.8% 90%;
    --sidebar-primary: 224 76.3% 48%;
    --sidebar-primary-foreground: 0 0% 100%;
    --sidebar-accent: 224 20% 13%;
    --sidebar-accent-foreground: 240 4.8% 95%;
    --sidebar-border: 224 20% 14%;
    --sidebar-ring: 217.2 91.2% 59.8%;
  }
}

@layer base {
  * {
    @apply border-border;
    font-family: 'Plus Jakarta Sans', system-ui, -apple-system, sans-serif;
  }
  body {
    @apply bg-background text-foreground;
  }
}
EOF

# src/lib/utils.ts
cat << 'EOF' > src/lib/utils.ts
import { type ClassValue, clsx } from "clsx";
import { twMerge } from "tailwind-merge";

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs));
}

export function formatDate(date: Date | string | number): string {
  return new Intl.DateTimeFormat("vi-VN", {
    hour: "2-digit",
    minute: "2-digit",
    second: "2-digit",
    day: "2-digit",
    month: "2-digit",
    year: "numeric",
  }).format(new Date(date));
}
EOF

# ------------------------------------------------------------------------------
# 5. shadcn/ui Components
# ------------------------------------------------------------------------------
echo -e "${BLUE}🧩 [5/8] Cài đặt UI Components (Button, Card, Badge, Avatar, Tooltip)...${NC}"

# Button
cat << 'EOF' > src/components/ui/button.tsx
import * as React from "react";
import { Slot } from "@radix-ui/react-slot";
import { cva, type VariantProps } from "class-variance-authority";
import { cn } from "@/lib/utils";

const buttonVariants = cva(
  "inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-lg text-sm font-medium transition-all focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:pointer-events-none disabled:opacity-50 active:scale-[0.98]",
  {
    variants: {
      variant: {
        default:
          "bg-primary text-primary-foreground shadow-sm hover:bg-primary/90 shadow-primary/25 hover:shadow-md hover:shadow-primary/30",
        destructive:
          "bg-destructive text-destructive-foreground shadow-sm hover:bg-destructive/90",
        outline:
          "border border-input bg-background/50 backdrop-blur-sm shadow-sm hover:bg-accent hover:text-accent-foreground",
        secondary:
          "bg-secondary text-secondary-foreground shadow-sm hover:bg-secondary/80",
        ghost: "hover:bg-accent hover:text-accent-foreground",
        link: "text-primary underline-offset-4 hover:underline",
      },
      size: {
        default: "h-10 px-4 py-2",
        sm: "h-8 rounded-md px-3 text-xs",
        lg: "h-12 rounded-xl px-8 text-base",
        icon: "h-10 w-10",
      },
    },
    defaultVariants: {
      variant: "default",
      size: "default",
    },
  }
);

export interface ButtonProps
  extends React.ButtonHTMLAttributes<HTMLButtonElement>,
    VariantProps<typeof buttonVariants> {
  asChild?: boolean;
}

const Button = React.forwardRef<HTMLButtonElement, ButtonProps>(
  ({ className, variant, size, asChild = false, ...props }, ref) => {
    const Comp = asChild ? Slot : "button";
    return (
      <Comp
        className={cn(buttonVariants({ variant, size, className }))}
        ref={ref}
        {...props}
      />
    );
  }
);
Button.displayName = "Button";

export { Button, buttonVariants };
EOF

# Card
cat << 'EOF' > src/components/ui/card.tsx
import * as React from "react";
import { cn } from "@/lib/utils";

const Card = React.forwardRef<HTMLDivElement, React.HTMLAttributes<HTMLDivElement>>(
  ({ className, ...props }, ref) => (
    <div
      ref={ref}
      className={cn(
        "rounded-2xl border bg-card text-card-foreground shadow-sm backdrop-blur-xl transition-all duration-200 hover:shadow-md",
        className
      )}
      {...props}
    />
  )
);
Card.displayName = "Card";

const CardHeader = React.forwardRef<HTMLDivElement, React.HTMLAttributes<HTMLDivElement>>(
  ({ className, ...props }, ref) => (
    <div ref={ref} className={cn("flex flex-col space-y-1.5 p-6", className)} {...props} />
  )
);
CardHeader.displayName = "CardHeader";

const CardTitle = React.forwardRef<HTMLParagraphElement, React.HTMLAttributes<HTMLHeadingElement>>(
  ({ className, ...props }, ref) => (
    <h3 ref={ref} className={cn("text-lg font-bold leading-none tracking-tight text-foreground/90", className)} {...props} />
  )
);
CardTitle.displayName = "CardTitle";

const CardDescription = React.forwardRef<HTMLParagraphElement, React.HTMLAttributes<HTMLParagraphElement>>(
  ({ className, ...props }, ref) => (
    <p ref={ref} className={cn("text-sm text-muted-foreground", className)} {...props} />
  )
);
CardDescription.displayName = "CardDescription";

const CardContent = React.forwardRef<HTMLDivElement, React.HTMLAttributes<HTMLDivElement>>(
  ({ className, ...props }, ref) => (
    <div ref={ref} className={cn("p-6 pt-0", className)} {...props} />
  )
);
CardContent.displayName = "CardContent";

const CardFooter = React.forwardRef<HTMLDivElement, React.HTMLAttributes<HTMLDivElement>>(
  ({ className, ...props }, ref) => (
    <div ref={ref} className={cn("flex items-center p-6 pt-0", className)} {...props} />
  )
);
CardFooter.displayName = "CardFooter";

export { Card, CardHeader, CardFooter, CardTitle, CardDescription, CardContent };
EOF

# Badge
cat << 'EOF' > src/components/ui/badge.tsx
import * as React from "react";
import { cva, type VariantProps } from "class-variance-authority";
import { cn } from "@/lib/utils";

const badgeVariants = cva(
  "inline-flex items-center rounded-full border px-2.5 py-0.5 text-xs font-semibold transition-colors focus:outline-none focus:ring-2 focus:ring-ring focus:ring-offset-2",
  {
    variants: {
      variant: {
        default:
          "border-transparent bg-primary text-primary-foreground shadow hover:bg-primary/80",
        secondary:
          "border-transparent bg-secondary text-secondary-foreground hover:bg-secondary/80",
        destructive:
          "border-transparent bg-destructive text-destructive-foreground shadow hover:bg-destructive/80",
        outline: "text-foreground",
        success:
          "border-transparent bg-emerald-500/15 text-emerald-600 dark:text-emerald-400 border border-emerald-500/20",
      },
    },
    defaultVariants: {
      variant: "default",
    },
  }
);

export interface BadgeProps
  extends React.HTMLAttributes<HTMLDivElement>,
    VariantProps<typeof badgeVariants> {}

function Badge({ className, variant, ...props }: BadgeProps) {
  return <div className={cn(badgeVariants({ variant }), className)} {...props} />;
}

export { Badge, badgeVariants };
EOF

# Avatar
cat << 'EOF' > src/components/ui/avatar.tsx
import * as React from "react";
import * as AvatarPrimitive from "@radix-ui/react-avatar";
import { cn } from "@/lib/utils";

const Avatar = React.forwardRef<
  React.ElementRef<typeof AvatarPrimitive.Root>,
  React.ComponentPropsWithoutRef<typeof AvatarPrimitive.Root>
>(({ className, ...props }, ref) => (
  <AvatarPrimitive.Root
    ref={ref}
    className={cn("relative flex h-10 w-10 shrink-0 overflow-hidden rounded-full ring-2 ring-border", className)}
    {...props}
  />
));
Avatar.displayName = AvatarPrimitive.Root.displayName;

const AvatarImage = React.forwardRef<
  React.ElementRef<typeof AvatarPrimitive.Image>,
  React.ComponentPropsWithoutRef<typeof AvatarPrimitive.Image>
>(({ className, ...props }, ref) => (
  <AvatarPrimitive.Image
    ref={ref}
    className={cn("aspect-square h-full w-full object-cover", className)}
    {...props}
  />
));
AvatarImage.displayName = AvatarPrimitive.Image.displayName;

const AvatarFallback = React.forwardRef<
  React.ElementRef<typeof AvatarPrimitive.Fallback>,
  React.ComponentPropsWithoutRef<typeof AvatarPrimitive.Fallback>
>(({ className, ...props }, ref) => (
  <AvatarPrimitive.Fallback
    ref={ref}
    className={cn("flex h-full w-full items-center justify-center rounded-full bg-muted font-semibold text-muted-foreground", className)}
    {...props}
  />
));
AvatarFallback.displayName = AvatarPrimitive.Fallback.displayName;

export { Avatar, AvatarImage, AvatarFallback };
EOF

# ------------------------------------------------------------------------------
# 6. Zustand Stores
# ------------------------------------------------------------------------------
echo -e "${BLUE}🗄️  [6/8] Thiết lập Zustand Stores...${NC}"

# Types
cat << 'EOF' > src/types/index.ts
export type Theme = "light" | "dark" | "system";

export interface User {
  id: string;
  name: string;
  email: string;
  avatar: string;
  role: "admin" | "hacker" | "viewer";
}

export interface WorkerMessage {
  id: string;
  senderId: string;
  type: "CHAT" | "COUNTER_UPDATE" | "PING" | "PONG" | "SYSTEM";
  payload: any;
  timestamp: number;
}
EOF

# App Store
cat << 'EOF' > src/stores/appStore.ts
import { create } from "zustand";
import { persist, createJSONStorage } from "zustand/middleware";
import { Theme } from "@/types";

interface AppState {
  theme: Theme;
  isSidebarCollapsed: boolean;
  isMobileSidebarOpen: boolean;
  setTheme: (theme: Theme) => void;
  toggleSidebar: () => void;
  setSidebarCollapsed: (collapsed: boolean) => void;
  setMobileSidebarOpen: (open: boolean) => void;
}

export const useAppStore = create<AppState>()(
  persist(
    (set) => ({
      theme: "dark",
      isSidebarCollapsed: false,
      isMobileSidebarOpen: false,
      setTheme: (theme) => {
        set({ theme });
        if (typeof document !== "undefined") {
          const root = document.documentElement;
          root.classList.remove("light", "dark");
          if (theme === "system") {
            const systemDark = window.matchMedia("(prefers-color-scheme: dark)").matches;
            root.classList.add(systemDark ? "dark" : "light");
          } else {
            root.classList.add(theme);
          }
        }
      },
      toggleSidebar: () => set((state) => ({ isSidebarCollapsed: !state.isSidebarCollapsed })),
      setSidebarCollapsed: (isSidebarCollapsed) => set({ isSidebarCollapsed }),
      setMobileSidebarOpen: (isMobileSidebarOpen) => set({ isMobileSidebarOpen }),
    }),
    {
      name: "hackathon-app-storage",
      storage: createJSONStorage(() => localStorage),
    }
  )
);
EOF

# Auth Store
cat << 'EOF' > src/stores/authStore.ts
import { create } from "zustand";
import { persist } from "zustand/middleware";
import { User } from "@/types";

interface AuthState {
  user: User | null;
  isAuthenticated: boolean;
  login: (user: User) => void;
  logout: () => void;
}

export const useAuthStore = create<AuthState>()(
  persist(
    (set) => ({
      user: {
        id: "user-01",
        name: "Hacker Alex",
        email: "alex@hackathon.dev",
        avatar: "https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150&auto=format&fit=crop&q=80",
        role: "hacker",
      },
      isAuthenticated: true,
      login: (user) => set({ user, isAuthenticated: true }),
      logout: () => set({ user: null, isAuthenticated: false }),
    }),
    {
      name: "hackathon-auth-storage",
    }
  )
);
EOF

# Worker Store
cat << 'EOF' > src/stores/workerStore.ts
import { create } from "zustand";
import { WorkerMessage } from "@/types";

interface WorkerState {
  isSharedWorkerActive: boolean;
  tabId: string;
  activeTabsCount: number;
  sharedCounter: number;
  messages: WorkerMessage[];
  lastPing: number | null;
  setSharedWorkerActive: (active: boolean) => void;
  setTabId: (id: string) => void;
  setActiveTabsCount: (count: number) => void;
  setSharedCounter: (count: number) => void;
  addMessage: (msg: WorkerMessage) => void;
  clearMessages: () => void;
  setLastPing: (timestamp: number) => void;
}

export const useWorkerStore = create<WorkerState>((set) => ({
  isSharedWorkerActive: false,
  tabId: `tab-${Math.random().toString(36).substring(2, 8)}`,
  activeTabsCount: 1,
  sharedCounter: 0,
  messages: [],
  lastPing: null,
  setSharedWorkerActive: (isSharedWorkerActive) => set({ isSharedWorkerActive }),
  setTabId: (tabId) => set({ tabId }),
  setActiveTabsCount: (activeTabsCount) => set({ activeTabsCount }),
  setSharedCounter: (sharedCounter) => set({ sharedCounter }),
  addMessage: (msg) =>
    set((state) => ({
      messages: [msg, ...state.messages].slice(0, 50),
    })),
  clearMessages: () => set({ messages: [] }),
  setLastPing: (lastPing) => set({ lastPing }),
}));
EOF

# ------------------------------------------------------------------------------
# 7. Shared Worker & Service Worker
# ------------------------------------------------------------------------------
echo -e "${BLUE}⚡ [7/8] Thiết lập Shared Worker & Service Worker...${NC}"

# Shared Worker Code
cat << 'EOF' > src/workers/shared-worker.ts
/// <reference lib="webworker" />

interface ClientConnection {
  port: MessagePort;
  tabId: string;
  connectedAt: number;
}

let connections: ClientConnection[] = [];
let sharedCounter = 0;

const broadcast = (data: any, excludePort?: MessagePort) => {
  connections.forEach(({ port }) => {
    if (port !== excludePort) {
      try {
        port.postMessage(data);
      } catch (e) {
        console.error("Lỗi broadcast port:", e);
      }
    }
  });
};

const broadcastTabsCount = () => {
  broadcast({
    type: "TABS_COUNT_UPDATE",
    payload: { count: connections.length },
  });
};

// @ts-ignore
self.onconnect = (event: MessageEvent) => {
  const port = event.ports[0];
  let clientTabId = "unknown";

  port.onmessage = (e: MessageEvent) => {
    const { type, payload, senderId } = e.data || {};

    switch (type) {
      case "INIT_TAB": {
        clientTabId = senderId || `tab-${Date.now()}`;
        connections.push({ port, tabId: clientTabId, connectedAt: Date.now() });

        port.postMessage({
          type: "INIT_SUCCESS",
          payload: {
            sharedCounter,
            activeTabsCount: connections.length,
            tabId: clientTabId,
          },
        });

        broadcastTabsCount();
        break;
      }

      case "INCREMENT_COUNTER": {
        sharedCounter += payload?.amount || 1;
        broadcast({
          type: "COUNTER_UPDATE",
          payload: { counter: sharedCounter, updatedBy: senderId },
        });
        break;
      }

      case "DECREMENT_COUNTER": {
        sharedCounter -= payload?.amount || 1;
        broadcast({
          type: "COUNTER_UPDATE",
          payload: { counter: sharedCounter, updatedBy: senderId },
        });
        break;
      }

      case "RESET_COUNTER": {
        sharedCounter = 0;
        broadcast({
          type: "COUNTER_UPDATE",
          payload: { counter: sharedCounter, updatedBy: senderId },
        });
        break;
      }

      case "CHAT_MESSAGE": {
        broadcast({
          type: "CHAT_MESSAGE",
          payload: {
            id: `msg-${Date.now()}-${Math.random().toString(36).substr(2, 4)}`,
            senderId,
            text: payload.text,
            timestamp: Date.now(),
          },
        });
        break;
      }

      case "PING": {
        port.postMessage({
          type: "PONG",
          payload: { timestamp: Date.now() },
        });
        break;
      }

      default:
        console.warn("Unknown worker action:", type);
    }
  };

  port.start();
};
EOF

# Hook useSharedWorker
cat << 'EOF' > src/hooks/useSharedWorker.ts
import { useEffect, useRef, useCallback } from "react";
import { useWorkerStore } from "@/stores/workerStore";

export function useSharedWorker() {
  const workerRef = useRef<SharedWorker | null>(null);
  const portRef = useRef<MessagePort | null>(null);
  const broadcastChannelRef = useRef<BroadcastChannel | null>(null);

  const {
    tabId,
    setSharedWorkerActive,
    setActiveTabsCount,
    setSharedCounter,
    addMessage,
    setLastPing,
  } = useWorkerStore();

  const handleWorkerMessage = useCallback(
    (event: MessageEvent) => {
      const { type, payload } = event.data || {};

      switch (type) {
        case "INIT_SUCCESS":
          setSharedWorkerActive(true);
          setSharedCounter(payload.sharedCounter);
          setActiveTabsCount(payload.activeTabsCount);
          break;

        case "TABS_COUNT_UPDATE":
          setActiveTabsCount(payload.count);
          break;

        case "COUNTER_UPDATE":
          setSharedCounter(payload.counter);
          addMessage({
            id: `counter-${Date.now()}`,
            senderId: payload.updatedBy,
            type: "COUNTER_UPDATE",
            payload: { counter: payload.counter },
            timestamp: Date.now(),
          });
          break;

        case "CHAT_MESSAGE":
          addMessage({
            id: payload.id,
            senderId: payload.senderId,
            type: "CHAT",
            payload: { text: payload.text },
            timestamp: payload.timestamp,
          });
          break;

        case "PONG":
          setLastPing(payload.timestamp);
          break;

        default:
          break;
      }
    },
    [addMessage, setActiveTabsCount, setLastPing, setSharedCounter, setSharedWorkerActive]
  );

  useEffect(() => {
    if (typeof SharedWorker !== "undefined") {
      try {
        const worker = new SharedWorker(
          new URL("../workers/shared-worker.ts", import.meta.url),
          { type: "module", name: "HackathonSharedWorker" }
        );

        workerRef.current = worker;
        portRef.current = worker.port;

        worker.port.onmessage = handleWorkerMessage;
        worker.port.start();

        worker.port.postMessage({
          type: "INIT_TAB",
          senderId: tabId,
        });

        setSharedWorkerActive(true);
      } catch (err) {
        console.warn("SharedWorker fallback sang BroadcastChannel:", err);
        setupBroadcastChannelFallback();
      }
    } else {
      setupBroadcastChannelFallback();
    }

    function setupBroadcastChannelFallback() {
      if (typeof BroadcastChannel !== "undefined") {
        const bc = new BroadcastChannel("hackathon-channel");
        broadcastChannelRef.current = bc;
        bc.onmessage = (event) => handleWorkerMessage(event);
        setSharedWorkerActive(true);
      }
    }

    return () => {
      if (portRef.current) portRef.current.close();
      if (broadcastChannelRef.current) broadcastChannelRef.current.close();
    };
  }, [tabId, handleWorkerMessage, setSharedWorkerActive]);

  const incrementCounter = (amount = 1) => {
    const msg = { type: "INCREMENT_COUNTER", senderId: tabId, payload: { amount } };
    if (portRef.current) portRef.current.postMessage(msg);
    else if (broadcastChannelRef.current) broadcastChannelRef.current.postMessage(msg);
  };

  const decrementCounter = (amount = 1) => {
    const msg = { type: "DECREMENT_COUNTER", senderId: tabId, payload: { amount } };
    if (portRef.current) portRef.current.postMessage(msg);
    else if (broadcastChannelRef.current) broadcastChannelRef.current.postMessage(msg);
  };

  const resetCounter = () => {
    const msg = { type: "RESET_COUNTER", senderId: tabId };
    if (portRef.current) portRef.current.postMessage(msg);
    else if (broadcastChannelRef.current) broadcastChannelRef.current.postMessage(msg);
  };

  const sendChatMessage = (text: string) => {
    if (!text.trim()) return;
    const msg = { type: "CHAT_MESSAGE", senderId: tabId, payload: { text } };
    if (portRef.current) portRef.current.postMessage(msg);
    else if (broadcastChannelRef.current) broadcastChannelRef.current.postMessage(msg);
  };

  const pingWorker = () => {
    const msg = { type: "PING", senderId: tabId };
    if (portRef.current) portRef.current.postMessage(msg);
  };

  return {
    tabId,
    incrementCounter,
    decrementCounter,
    resetCounter,
    sendChatMessage,
    pingWorker,
  };
}
EOF

# public/sw.js
cat << 'EOF' > public/sw.js
const CACHE_NAME = "hackathon-cache-v1";
const ASSETS_TO_CACHE = [
  "/",
  "/index.html",
  "/vite.svg"
];

self.addEventListener("install", (event) => {
  event.waitUntil(
    caches.open(CACHE_NAME).then((cache) => cache.addAll(ASSETS_TO_CACHE))
  );
  self.skipWaiting();
});

self.addEventListener("activate", (event) => {
  event.waitUntil(
    caches.keys().then((keys) =>
      Promise.all(
        keys.map((key) => {
          if (key !== CACHE_NAME) return caches.delete(key);
        })
      )
    )
  );
  return self.clients.claim();
});

self.addEventListener("fetch", (event) => {
  if (event.request.method !== "GET") return;

  event.respondWith(
    fetch(event.request)
      .then((networkResponse) => {
        if (
          networkResponse &&
          networkResponse.status === 200 &&
          (event.request.url.startsWith("http://") || event.request.url.startsWith("https://"))
        ) {
          const responseToCache = networkResponse.clone();
          caches.open(CACHE_NAME).then((cache) => {
            cache.put(event.request, responseToCache);
          });
        }
        return networkResponse;
      })
      .catch(() => caches.match(event.request))
  );
});
EOF

# Hook useServiceWorker
cat << 'EOF' > src/hooks/useServiceWorker.ts
import { useState, useEffect } from "react";

export function useServiceWorker() {
  const [isRegistered, setIsRegistered] = useState(false);
  const [isOnline, setIsOnline] = useState(navigator.onLine);
  const [hasUpdate, setHasUpdate] = useState(false);

  useEffect(() => {
    const handleOnline = () => setIsOnline(true);
    const handleOffline = () => setIsOnline(false);

    window.addEventListener("online", handleOnline);
    window.addEventListener("offline", handleOffline);

    if ("serviceWorker" in navigator && process.env.NODE_ENV !== "development") {
      navigator.serviceWorker
        .register("/sw.js")
        .then((reg) => {
          setIsRegistered(true);
          reg.onupdatefound = () => {
            const installingWorker = reg.installing;
            if (installingWorker) {
              installingWorker.onstatechange = () => {
                if (
                  installingWorker.state === "installed" &&
                  navigator.serviceWorker.controller
                ) {
                  setHasUpdate(true);
                }
              };
            }
          };
        })
        .catch((err) => {
          console.error("[SW] Đăng ký thất bại:", err);
        });
    }

    return () => {
      window.removeEventListener("online", handleOnline);
      window.removeEventListener("offline", handleOffline);
    };
  }, []);

  const updateServiceWorker = () => {
    window.location.reload();
  };

  return {
    isRegistered,
    isOnline,
    hasUpdate,
    updateServiceWorker,
  };
}
EOF

# ------------------------------------------------------------------------------
# 8. Layouts, Navigation & Pages
# ------------------------------------------------------------------------------
echo -e "${BLUE}📐 [8/8] Xây dựng Layout, Sidebar Navigation & Pages...${NC}"

# Header
cat << 'EOF' > src/components/layout/Header.tsx
import React from "react";
import { Menu, Moon, Sun, Users } from "lucide-react";
import { useAppStore } from "@/stores/appStore";
import { useWorkerStore } from "@/stores/workerStore";
import { useAuthStore } from "@/stores/authStore";
import { Button } from "@/components/ui/button";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Badge } from "@/components/ui/badge";

export const Header: React.FC = () => {
  const { theme, setTheme, toggleSidebar, setMobileSidebarOpen } = useAppStore();
  const { activeTabsCount, isSharedWorkerActive } = useWorkerStore();
  const { user } = useAuthStore();

  return (
    <header className="sticky top-0 z-30 flex h-16 w-full items-center justify-between border-b bg-background/80 px-4 backdrop-blur-md transition-all lg:px-6">
      <div className="flex items-center gap-3">
        <Button
          variant="ghost"
          size="icon"
          className="lg:hidden"
          onClick={() => setMobileSidebarOpen(true)}
        >
          <Menu className="h-5 w-5" />
        </Button>

        <Button
          variant="ghost"
          size="icon"
          className="hidden lg:flex"
          onClick={toggleSidebar}
          title="Thu gọn / Mở rộng Sidebar"
        >
          <Menu className="h-5 w-5" />
        </Button>

        <div className="flex items-center gap-2">
          <span className="bg-gradient-to-r from-primary via-indigo-500 to-purple-500 bg-clip-text text-lg font-extrabold text-transparent">
            HACKATHON
          </span>
          <Badge variant="outline" className="hidden sm:inline-flex text-[10px] font-bold uppercase tracking-wider">
            React 19 + TS
          </Badge>
        </div>
      </div>

      <div className="flex items-center gap-2 sm:gap-4">
        <div className="flex items-center gap-1.5 rounded-full bg-secondary/80 px-3 py-1 text-xs font-medium backdrop-blur-sm border">
          <Users className="h-3.5 w-3.5 text-primary" />
          <span className="hidden sm:inline text-muted-foreground">Tabs:</span>
          <span className="font-bold text-foreground">{activeTabsCount}</span>
          <span
            className={`h-2 w-2 rounded-full ${
              isSharedWorkerActive ? "bg-emerald-500 animate-pulse" : "bg-muted"
            }`}
          />
        </div>

        <Button
          variant="ghost"
          size="icon"
          onClick={() => setTheme(theme === "dark" ? "light" : "dark")}
          className="rounded-full"
        >
          {theme === "dark" ? (
            <Sun className="h-4 w-4 text-amber-400" />
          ) : (
            <Moon className="h-4 w-4 text-slate-700" />
          )}
        </Button>

        {user && (
          <div className="flex items-center gap-2 pl-2">
            <Avatar className="h-8 w-8 ring-2 ring-primary/20">
              <AvatarImage src={user.avatar} alt={user.name} />
              <AvatarFallback>{user.name.charAt(0)}</AvatarFallback>
            </Avatar>
            <div className="hidden text-left md:block">
              <p className="text-xs font-semibold leading-none">{user.name}</p>
              <p className="text-[10px] text-muted-foreground capitalize">{user.role}</p>
            </div>
          </div>
        )}
      </div>
    </header>
  );
};
EOF

# Sidebar
cat << 'EOF' > src/components/layout/Sidebar.tsx
import React from "react";
import { NavLink } from "react-router-dom";
import {
  LayoutDashboard,
  Cpu,
  BarChart3,
  Settings,
  Flame,
  X,
  Sparkles,
} from "lucide-react";
import { useAppStore } from "@/stores/appStore";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { cn } from "@/lib/utils";

interface NavItem {
  title: string;
  path: string;
  icon: React.ElementType;
  badge?: string;
}

const navItems: NavItem[] = [
  { title: "Dashboard", path: "/", icon: LayoutDashboard },
  { title: "Shared Worker Sync", path: "/worker-sync", icon: Cpu, badge: "Multi-tab" },
  { title: "Analytics", path: "/analytics", icon: BarChart3 },
  { title: "Settings", path: "/settings", icon: Settings },
];

export const Sidebar: React.FC = () => {
  const { isSidebarCollapsed, isMobileSidebarOpen, setMobileSidebarOpen } = useAppStore();

  const renderNavLinks = () => (
    <div className="flex flex-col gap-1.5 px-3 py-4">
      {navItems.map((item) => {
        const Icon = item.icon;
        return (
          <NavLink
            key={item.path}
            to={item.path}
            onClick={() => setMobileSidebarOpen(false)}
            className={({ isActive }) =>
              cn(
                "group relative flex items-center gap-3 rounded-xl px-3 py-2.5 text-sm font-medium transition-all duration-200",
                isActive
                  ? "bg-primary text-primary-foreground shadow-md shadow-primary/20"
                  : "text-muted-foreground hover:bg-accent hover:text-foreground"
              )
            }
          >
            <Icon className="h-5 w-5 shrink-0 transition-transform group-hover:scale-110" />
            <span
              className={cn(
                "truncate transition-opacity duration-200",
                isSidebarCollapsed ? "lg:hidden" : "block"
              )}
            >
              {item.title}
            </span>

            {item.badge && !isSidebarCollapsed && (
              <Badge
                variant="secondary"
                className="ml-auto hidden text-[10px] uppercase font-bold sm:inline-flex"
              >
                {item.badge}
              </Badge>
            )}
          </NavLink>
        );
      })}
    </div>
  );

  return (
    <>
      <aside
        className={cn(
          "hidden border-r bg-sidebar transition-all duration-300 ease-in-out lg:flex lg:flex-col",
          isSidebarCollapsed ? "w-20" : "w-64"
        )}
      >
        <div className="flex h-16 items-center gap-3 border-b px-5">
          <div className="flex h-9 w-9 shrink-0 items-center justify-center rounded-xl bg-gradient-to-tr from-primary to-indigo-500 shadow-md shadow-primary/30">
            <Flame className="h-5 w-5 text-white" />
          </div>
          {!isSidebarCollapsed && (
            <div className="flex flex-col">
              <span className="font-extrabold text-foreground tracking-tight">FAST PROTOTYPE</span>
              <span className="text-[10px] text-muted-foreground">Hackathon Edition</span>
            </div>
          )}
        </div>

        <div className="flex-1 overflow-y-auto">{renderNavLinks()}</div>

        {!isSidebarCollapsed && (
          <div className="p-4">
            <div className="rounded-xl border bg-gradient-to-br from-primary/10 via-background to-secondary p-3.5 text-center">
              <Sparkles className="mx-auto h-5 w-5 text-primary mb-1" />
              <p className="text-xs font-bold text-foreground">Hackathon Ready</p>
              <p className="text-[10px] text-muted-foreground mt-0.5">Zustand + Worker + shadcn/ui</p>
            </div>
          </div>
        )}
      </aside>

      {isMobileSidebarOpen && (
        <div className="fixed inset-0 z-50 flex lg:hidden">
          <div
            className="fixed inset-0 bg-background/80 backdrop-blur-sm transition-opacity"
            onClick={() => setMobileSidebarOpen(false)}
          />
          <div className="relative z-50 flex w-72 flex-col border-r bg-sidebar shadow-2xl">
            <div className="flex h-16 items-center justify-between border-b px-5">
              <div className="flex items-center gap-2">
                <div className="flex h-8 w-8 items-center justify-center rounded-lg bg-primary text-white">
                  <Flame className="h-4 w-4" />
                </div>
                <span className="font-bold text-foreground">HACKATHON</span>
              </div>
              <Button
                variant="ghost"
                size="icon"
                onClick={() => setMobileSidebarOpen(false)}
              >
                <X className="h-5 w-5" />
              </Button>
            </div>
            <div className="flex-1 overflow-y-auto">{renderNavLinks()}</div>
          </div>
        </div>
      )}
    </>
  );
};
EOF

# Layout
cat << 'EOF' > src/components/layout/AppLayout.tsx
import React from "react";
import { Outlet } from "react-router-dom";
import { Sidebar } from "./Sidebar";
import { Header } from "./Header";
import { useSharedWorker } from "@/hooks/useSharedWorker";
import { useServiceWorker } from "@/hooks/useServiceWorker";
import { RefreshCw, WifiOff } from "lucide-react";
import { Button } from "@/components/ui/button";

export const AppLayout: React.FC = () => {
  useSharedWorker();
  const { isOnline, hasUpdate, updateServiceWorker } = useServiceWorker();

  return (
    <div className="flex min-h-screen bg-background text-foreground">
      <Sidebar />
      <div className="flex flex-1 flex-col overflow-hidden">
        <Header />
        {!isOnline && (
          <div className="flex items-center justify-center gap-2 bg-destructive/15 px-4 py-2 text-xs font-semibold text-destructive border-b border-destructive/20">
            <WifiOff className="h-4 w-4" />
            Bạn đang offline! Ứng dụng vẫn hoạt động nhờ ServiceWorker cache.
          </div>
        )}
        {hasUpdate && (
          <div className="flex items-center justify-between bg-primary px-4 py-2 text-xs font-medium text-primary-foreground">
            <span>Phiên bản mới đã sẵn sàng!</span>
            <Button
              size="sm"
              variant="secondary"
              className="h-7 text-xs gap-1"
              onClick={updateServiceWorker}
            >
              <RefreshCw className="h-3 w-3" /> Cập nhật ngay
            </Button>
          </div>
        )}
        <main className="flex-1 overflow-y-auto p-4 md:p-6 lg:p-8">
          <Outlet />
        </main>
      </div>
    </div>
  );
};
EOF

# Dashboard Page
cat << 'EOF' > src/pages/Dashboard.tsx
import React from "react";
import {
  Activity,
  Boxes,
  Cpu,
  Layers,
  Share2,
  Users,
  Zap,
} from "lucide-react";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { useWorkerStore } from "@/stores/workerStore";
import { useAuthStore } from "@/stores/authStore";
import { Link } from "react-router-dom";

export const Dashboard: React.FC = () => {
  const { activeTabsCount, sharedCounter } = useWorkerStore();
  const { user } = useAuthStore();

  const stats = [
    {
      title: "Tabs Đang Mở",
      value: `${activeTabsCount} tabs`,
      desc: "Đồng bộ qua SharedWorker",
      icon: Users,
      color: "text-blue-500",
      bg: "bg-blue-500/10",
    },
    {
      title: "Shared Counter",
      value: sharedCounter,
      desc: "State chung giữa các tab",
      icon: Cpu,
      color: "text-purple-500",
      bg: "bg-purple-500/10",
    },
    {
      title: "Zustand Store",
      value: "Active",
      desc: "Persist & DevTools Ready",
      icon: Layers,
      color: "text-emerald-500",
      bg: "bg-emerald-500/10",
    },
    {
      title: "PWA & Cache",
      value: "Ready",
      desc: "Offline-first capability",
      icon: Zap,
      color: "text-amber-500",
      bg: "bg-amber-500/10",
    },
  ];

  return (
    <div className="space-y-6">
      <div className="relative overflow-hidden rounded-3xl border bg-gradient-to-r from-primary/10 via-purple-500/10 to-pink-500/10 p-6 md:p-8 backdrop-blur-xl">
        <div className="relative z-10 max-w-2xl space-y-3">
          <Badge variant="default" className="bg-primary/90">
            Hackathon Starter v1.0
          </Badge>
          <h1 className="text-2xl md:text-4xl font-extrabold tracking-tight text-foreground">
            Xin chào, {user?.name || "Hacker"}! 🚀
          </h1>
          <p className="text-sm md:text-base text-muted-foreground">
            Template chuẩn React 19 + TypeScript + Zustand + SharedWorker + ServiceWorker + shadcn/ui được tối ưu hóa cho các cuộc thi Hackathon đòi hỏi tốc độ phát triển cực nhanh.
          </p>
          <div className="flex flex-wrap gap-3 pt-2">
            <Link to="/worker-sync">
              <Button className="gap-2">
                <Cpu className="h-4 w-4" /> Thử nghiệm SharedWorker Multi-Tab
              </Button>
            </Link>
            <Link to="/analytics">
              <Button variant="outline" className="gap-2">
                <Activity className="h-4 w-4" /> Xem Analytics
              </Button>
            </Link>
          </div>
        </div>
      </div>

      <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-4">
        {stats.map((item, idx) => {
          const Icon = item.icon;
          return (
            <Card key={idx} className="relative overflow-hidden border">
              <CardHeader className="flex flex-row items-center justify-between pb-2">
                <CardTitle className="text-sm font-medium text-muted-foreground">
                  {item.title}
                </CardTitle>
                <div className={`rounded-xl p-2.5 ${item.bg}`}>
                  <Icon className={`h-4 w-4 ${item.color}`} />
                </div>
              </CardHeader>
              <CardContent>
                <div className="text-2xl font-black">{item.value}</div>
                <p className="text-xs text-muted-foreground mt-1">{item.desc}</p>
              </CardContent>
            </Card>
          );
        })}
      </div>

      <div className="grid gap-6 md:grid-cols-2">
        <Card>
          <CardHeader>
            <CardTitle className="flex items-center gap-2">
              <Boxes className="h-5 w-5 text-primary" />
              Công Nghệ Đã Tích Hợp Sẵn
            </CardTitle>
            <CardDescription>
              Mọi thành phần đã cấu hình và sẵn sàng code ngay lập tức
            </CardDescription>
          </CardHeader>
          <CardContent className="space-y-3">
            {[
              { name: "React 19 & TypeScript", desc: "Môi trường type-safe, tốc độ build Vite cực nhanh." },
              { name: "Tailwind CSS & shadcn/ui", desc: "Design system chuẩn mực, Dark/Light mode, animations." },
              { name: "Zustand State Management", desc: "Quản lý state toàn cục nhẹ nhàng, hỗ trợ LocalStorage persist." },
              { name: "React Router v7", desc: "Điều hướng trang, layout lồng nhau và 404 page." },
              { name: "Shared Worker", desc: "Giao tiếp và đồng bộ state tức thời giữa nhiều tab trình duyệt." },
              { name: "Service Worker PWA", desc: "Caching offline, chuẩn bị sẵn cho push notification." },
            ].map((tech, i) => (
              <div key={i} className="flex items-start gap-3 rounded-lg border bg-accent/30 p-3">
                <div className="mt-0.5 flex h-5 w-5 shrink-0 items-center justify-center rounded-full bg-emerald-500/20 text-emerald-500 text-xs font-bold">
                  ✓
                </div>
                <div>
                  <h4 className="text-sm font-bold">{tech.name}</h4>
                  <p className="text-xs text-muted-foreground">{tech.desc}</p>
                </div>
              </div>
            ))}
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle className="flex items-center gap-2">
              <Share2 className="h-5 w-5 text-primary" />
              Hướng Dẫn Nhanh Hackathon
            </CardTitle>
            <CardDescription>Cách tận dụng tối đa starter kit này</CardDescription>
          </CardHeader>
          <CardContent className="space-y-4">
            <div className="rounded-xl border p-4 bg-muted/40 space-y-2">
              <h4 className="text-xs font-bold uppercase tracking-wider text-primary">Bước 1: Mở nhiều Tab</h4>
              <p className="text-xs text-muted-foreground">
                Hãy mở thêm 1 hoặc 2 tab mới với cùng địa chỉ <code>localhost:3000</code> và vào trang <b>Shared Worker Sync</b> để xem state cập nhật theo thời gian thực!
              </p>
            </div>

            <div className="rounded-xl border p-4 bg-muted/40 space-y-2">
              <h4 className="text-xs font-bold uppercase tracking-wider text-primary">Bước 2: Thêm UI shadcn</h4>
              <p className="text-xs text-muted-foreground">
                Các component được đặt trong <code>src/components/ui</code>. Bạn có thể tự do chỉnh sửa hoặc import thêm Radix UI primitives.
              </p>
            </div>

            <div className="rounded-xl border p-4 bg-muted/40 space-y-2">
              <h4 className="text-xs font-bold uppercase tracking-wider text-primary">Bước 3: Mở rộng Zustand</h4>
              <p className="text-xs text-muted-foreground">
                Thêm stores mới tại <code>src/stores/</code> để quản lý dữ liệu nghiệp vụ của bài toán Hackathon.
              </p>
            </div>
          </CardContent>
        </Card>
      </div>
    </div>
  );
};
EOF

# WorkerSync Page
cat << 'EOF' > src/pages/WorkerSyncPage.tsx
import React, { useState } from "react";
import {
  Cpu,
  Plus,
  Minus,
  RotateCcw,
  Send,
  MessageSquare,
  Activity,
  ExternalLink,
} from "lucide-react";
import { Card, CardContent, CardHeader, CardTitle, CardDescription, CardFooter } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { useWorkerStore } from "@/stores/workerStore";
import { useSharedWorker } from "@/hooks/useSharedWorker";
import { formatDate } from "@/lib/utils";

export const WorkerSyncPage: React.FC = () => {
  const {
    tabId,
    activeTabsCount,
    sharedCounter,
    messages,
    isSharedWorkerActive,
    lastPing,
  } = useWorkerStore();

  const {
    incrementCounter,
    decrementCounter,
    resetCounter,
    sendChatMessage,
    pingWorker,
  } = useSharedWorker();

  const [inputMessage, setInputMessage] = useState("");

  const handleSend = (e: React.FormEvent) => {
    e.preventDefault();
    if (inputMessage.trim()) {
      sendChatMessage(inputMessage);
      setInputMessage("");
    }
  };

  return (
    <div className="space-y-6">
      <div className="flex flex-col gap-2 sm:flex-row sm:items-center sm:justify-between">
        <div>
          <h1 className="text-2xl sm:text-3xl font-extrabold tracking-tight">
            Shared Worker Multi-Tab Synchronization ⚡
          </h1>
          <p className="text-sm text-muted-foreground">
            Trình diễn khả năng đồng bộ dữ liệu siêu tốc giữa các Browser Tabs không cần WebSocket backend.
          </p>
        </div>

        <Button
          variant="outline"
          size="sm"
          className="gap-2 self-start"
          onClick={() => window.open(window.location.href, "_blank")}
        >
          <ExternalLink className="h-4 w-4" /> Mở thêm Tab mới
        </Button>
      </div>

      <div className="grid gap-4 sm:grid-cols-3">
        <Card className="border">
          <CardHeader className="pb-2">
            <CardTitle className="text-xs font-semibold text-muted-foreground uppercase">Tab ID hiện tại</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="font-mono text-lg font-bold text-primary">{tabId}</div>
          </CardContent>
        </Card>

        <Card className="border">
          <CardHeader className="pb-2">
            <CardTitle className="text-xs font-semibold text-muted-foreground uppercase">Số lượng Tab kết nối</CardTitle>
          </CardHeader>
          <CardContent className="flex items-center gap-2">
            <span className="text-2xl font-black">{activeTabsCount}</span>
            <Badge variant={activeTabsCount > 1 ? "success" : "secondary"}>
              {activeTabsCount > 1 ? "Đang đồng bộ đa tab" : "Mở thêm tab để test"}
            </Badge>
          </CardContent>
        </Card>

        <Card className="border">
          <CardHeader className="pb-2">
            <CardTitle className="text-xs font-semibold text-muted-foreground uppercase">Worker Status</CardTitle>
          </CardHeader>
          <CardContent className="flex items-center justify-between">
            <Badge variant={isSharedWorkerActive ? "success" : "destructive"}>
              {isSharedWorkerActive ? "SharedWorker Connected" : "Disconnected"}
            </Badge>
            <Button size="sm" variant="ghost" onClick={pingWorker} className="h-7 text-xs gap-1">
              <Activity className="h-3 w-3" /> Ping ({lastPing ? `${Date.now() - lastPing}ms` : "N/A"})
            </Button>
          </CardContent>
        </Card>
      </div>

      <div className="grid gap-6 lg:grid-cols-2">
        <Card className="border shadow-sm">
          <CardHeader>
            <CardTitle className="flex items-center gap-2">
              <Cpu className="h-5 w-5 text-primary" />
              Shared Counter (Đồng bộ tức thì)
            </CardTitle>
            <CardDescription>
              Khi bạn bấm nút tăng/giảm, biến đếm sẽ thay đổi đồng thời trên TOÀN BỘ các tab đang mở!
            </CardDescription>
          </CardHeader>
          <CardContent className="flex flex-col items-center justify-center py-6">
            <div className="mb-6 font-mono text-6xl font-black text-primary tracking-tight">
              {sharedCounter}
            </div>
            <div className="flex flex-wrap items-center gap-3">
              <Button size="lg" onClick={() => incrementCounter(1)} className="gap-2">
                <Plus className="h-5 w-5" /> Tăng (+1)
              </Button>
              <Button size="lg" variant="secondary" onClick={() => decrementCounter(1)} className="gap-2">
                <Minus className="h-5 w-5" /> Giảm (-1)
              </Button>
              <Button size="lg" variant="outline" onClick={resetCounter} className="gap-2">
                <RotateCcw className="h-4 w-4" /> Reset (0)
              </Button>
            </div>
          </CardContent>
        </Card>

        <Card className="flex flex-col border shadow-sm">
          <CardHeader>
            <CardTitle className="flex items-center gap-2">
              <MessageSquare className="h-5 w-5 text-primary" />
              Cross-Tab Broadcast Log
            </CardTitle>
            <CardDescription>
              Gửi tin nhắn hoặc sự kiện từ tab này sang tất cả các tab khác
            </CardDescription>
          </CardHeader>

          <CardContent className="flex-1 space-y-3 max-h-72 overflow-y-auto">
            {messages.length === 0 ? (
              <div className="py-8 text-center text-xs text-muted-foreground">
                Chưa có sự kiện nào. Hãy bấm tăng counter hoặc gửi tin nhắn bên dưới!
              </div>
            ) : (
              messages.map((msg) => (
                <div
                  key={msg.id}
                  className={`rounded-xl p-3 text-xs border ${
                    msg.senderId === tabId
                      ? "bg-primary/10 border-primary/20"
                      : "bg-accent/40 border-border"
                  }`}
                >
                  <div className="flex items-center justify-between mb-1">
                    <span className="font-bold text-foreground">
                      {msg.senderId === tabId ? "Bạn (Tab này)" : `Tab: ${msg.senderId}`}
                    </span>
                    <span className="text-[10px] text-muted-foreground">
                      {formatDate(msg.timestamp)}
                    </span>
                  </div>
                  {msg.type === "CHAT" ? (
                    <p className="text-foreground/90">{msg.payload.text}</p>
                  ) : (
                    <p className="text-muted-foreground italic">
                      Cập nhật Counter: <b className="text-foreground">{msg.payload.counter}</b>
                    </p>
                  )}
                </div>
              ))
            )}
          </CardContent>

          <CardFooter className="pt-3 border-t">
            <form onSubmit={handleSend} className="flex w-full gap-2">
              <input
                type="text"
                value={inputMessage}
                onChange={(e) => setInputMessage(e.target.value)}
                placeholder="Nhập tin nhắn broadcast tới các tab khác..."
                className="flex h-10 w-full rounded-lg border border-input bg-background px-3 py-2 text-sm ring-offset-background placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring"
              />
              <Button type="submit" size="default" className="gap-1.5 shrink-0">
                <Send className="h-4 w-4" /> Gửi
              </Button>
            </form>
          </CardFooter>
        </Card>
      </div>
    </div>
  );
};
EOF

# Analytics Page
cat << 'EOF' > src/pages/AnalyticsPage.tsx
import React from "react";
import { TrendingUp, Users, Clock, ShieldCheck } from "lucide-react";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";

export const AnalyticsPage: React.FC = () => {
  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl sm:text-3xl font-extrabold tracking-tight">Analytics & Metrics 📊</h1>
        <p className="text-sm text-muted-foreground">
          Trang mẫu theo dõi hiệu năng và chỉ số ứng dụng thời gian thực.
        </p>
      </div>

      <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-4">
        {[
          { title: "Thời gian phản hồi UI", value: "1.2 ms", change: "+99.8% Faster", icon: Clock },
          { title: "Băng thông Cache SW", value: "84.2 MB", change: "Offline Ready", icon: ShieldCheck },
          { title: "Tải CPU Worker", value: "< 0.5%", change: "Off-thread processing", icon: TrendingUp },
          { title: "Lượt tương tác", value: "1,248", change: "+14% hôm nay", icon: Users },
        ].map((item, i) => {
          const Icon = item.icon;
          return (
            <Card key={i} className="border">
              <CardHeader className="flex flex-row items-center justify-between pb-2">
                <CardTitle className="text-xs font-semibold text-muted-foreground uppercase">{item.title}</CardTitle>
                <Icon className="h-4 w-4 text-primary" />
              </CardHeader>
              <CardContent>
                <div className="text-2xl font-bold">{item.value}</div>
                <Badge variant="outline" className="mt-1 text-[10px] text-emerald-500">
                  {item.change}
                </Badge>
              </CardContent>
            </Card>
          );
        })}
      </div>

      <Card className="border">
        <CardHeader>
          <CardTitle>Biểu đồ hiệu năng Hackathon</CardTitle>
          <CardDescription>Sử dụng CSS Native Bars hoặc tích hợp Recharts / Chart.js tùy nhu cầu.</CardDescription>
        </CardHeader>
        <CardContent className="h-64 flex items-end gap-3 pt-8 pb-4">
          {[45, 78, 56, 92, 64, 88, 95, 70, 85, 100].map((val, idx) => (
            <div key={idx} className="flex-1 flex flex-col items-center gap-2 h-full justify-end group">
              <div
                style={{ height: `${val}%` }}
                className="w-full rounded-t-lg bg-gradient-to-t from-primary/60 to-primary transition-all duration-300 group-hover:opacity-80 group-hover:scale-y-105"
              />
              <span className="text-[10px] text-muted-foreground">T{idx + 1}</span>
            </div>
          ))}
        </CardContent>
      </Card>
    </div>
  );
};
EOF

# Settings Page
cat << 'EOF' > src/pages/SettingsPage.tsx
import React from "react";
import { Moon, Sun, Laptop, Trash2 } from "lucide-react";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { useAppStore } from "@/stores/appStore";
import { useWorkerStore } from "@/stores/workerStore";

export const SettingsPage: React.FC = () => {
  const { theme, setTheme } = useAppStore();
  const { clearMessages } = useWorkerStore();

  const handleClearCache = async () => {
    if ("caches" in window) {
      const keys = await caches.keys();
      await Promise.all(keys.map((k) => caches.delete(k)));
      alert("Đã xóa toàn bộ Service Worker Caches thành công!");
    }
  };

  return (
    <div className="max-w-4xl space-y-6">
      <div>
        <h1 className="text-2xl sm:text-3xl font-extrabold tracking-tight">Cài Đặt Hệ Thống ⚙️</h1>
        <p className="text-sm text-muted-foreground">
          Quản lý giao diện, trạng thái bộ nhớ đệm và thiết lập ứng dụng.
        </p>
      </div>

      <Card className="border">
        <CardHeader>
          <CardTitle>Giao diện (Theme Mode)</CardTitle>
          <CardDescription>Chọn chế độ hiển thị phù hợp với sở thích của bạn.</CardDescription>
        </CardHeader>
        <CardContent className="flex flex-wrap gap-3">
          <Button
            variant={theme === "light" ? "default" : "outline"}
            onClick={() => setTheme("light")}
            className="gap-2"
          >
            <Sun className="h-4 w-4 text-amber-500" /> Sáng (Light)
          </Button>
          <Button
            variant={theme === "dark" ? "default" : "outline"}
            onClick={() => setTheme("dark")}
            className="gap-2"
          >
            <Moon className="h-4 w-4 text-indigo-400" /> Tối (Dark)
          </Button>
          <Button
            variant={theme === "system" ? "default" : "outline"}
            onClick={() => setTheme("system")}
            className="gap-2"
          >
            <Laptop className="h-4 w-4" /> Theo Hệ Thống (System)
          </Button>
        </CardContent>
      </Card>

      <Card className="border">
        <CardHeader>
          <CardTitle>Quản Lý Dữ Liệu & Bộ Nhớ</CardTitle>
          <CardDescription>Xóa log tin nhắn worker hoặc xóa bộ nhớ đệm PWA Service Worker.</CardDescription>
        </CardHeader>
        <CardContent className="space-y-4">
          <div className="flex items-center justify-between rounded-xl border p-4">
            <div>
              <p className="text-sm font-semibold">Xóa Lịch Sử Tin Nhắn Worker</p>
              <p className="text-xs text-muted-foreground">Xóa toàn bộ log cross-tab broadcast hiện tại.</p>
            </div>
            <Button variant="outline" size="sm" onClick={clearMessages} className="gap-1.5 text-destructive">
              <Trash2 className="h-4 w-4" /> Xóa Log
            </Button>
          </div>

          <div className="flex items-center justify-between rounded-xl border p-4">
            <div>
              <p className="text-sm font-semibold">Xóa Cache Service Worker</p>
              <p className="text-xs text-muted-foreground">Làm mới dữ liệu offline cache của trình duyệt.</p>
            </div>
            <Button variant="outline" size="sm" onClick={handleClearCache} className="gap-1.5">
              <Trash2 className="h-4 w-4" /> Xóa Cache SW
            </Button>
          </div>
        </CardContent>
      </Card>
    </div>
  );
};
EOF

# NotFound Page
cat << 'EOF' > src/pages/NotFound.tsx
import React from "react";
import { Link } from "react-router-dom";
import { Home } from "lucide-react";
import { Button } from "@/components/ui/button";

export const NotFound: React.FC = () => {
  return (
    <div className="flex min-h-[60vh] flex-col items-center justify-center text-center space-y-4">
      <div className="font-mono text-8xl font-black text-primary/40">404</div>
      <h2 className="text-2xl font-bold">Trang không tồn tại</h2>
      <p className="max-w-md text-sm text-muted-foreground">
        Đường dẫn bạn truy cập không hợp lệ hoặc đã bị thay đổi.
      </p>
      <Link to="/">
        <Button className="gap-2 mt-2">
          <Home className="h-4 w-4" /> Quay về Trang chủ
        </Button>
      </Link>
    </div>
  );
};
EOF

# Routes & Main Entry
cat << 'EOF' > src/routes/AppRoutes.tsx
import React from "react";
import { createBrowserRouter, RouterProvider } from "react-router-dom";
import { AppLayout } from "@/components/layout/AppLayout";
import { Dashboard } from "@/pages/Dashboard";
import { WorkerSyncPage } from "@/pages/WorkerSyncPage";
import { AnalyticsPage } from "@/pages/AnalyticsPage";
import { SettingsPage } from "@/pages/SettingsPage";
import { NotFound } from "@/pages/NotFound";

const router = createBrowserRouter([
  {
    path: "/",
    element: <AppLayout />,
    children: [
      { index: true, element: <Dashboard /> },
      { path: "worker-sync", element: <WorkerSyncPage /> },
      { path: "analytics", element: <AnalyticsPage /> },
      { path: "settings", element: <SettingsPage /> },
      { path: "*", element: <NotFound /> },
    ],
  },
]);

export const AppRoutes: React.FC = () => {
  return <RouterProvider router={router} />;
};
EOF

cat << 'EOF' > src/App.tsx
import React, { useEffect } from "react";
import { AppRoutes } from "@/routes/AppRoutes";
import { useAppStore } from "@/stores/appStore";

export const App: React.FC = () => {
  const { theme, setTheme } = useAppStore();

  useEffect(() => {
    setTheme(theme);
  }, []);

  return <AppRoutes />;
};

export default App;
EOF

cat << 'EOF' > src/main.tsx
import React from "react";
import ReactDOM from "react-dom/client";
import App from "./App";
import "./index.css";

ReactDOM.createRoot(document.getElementById("root")!).render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);
EOF

cat << 'EOF' > .gitignore
# Logs
logs
*.log
npm-debug.log*
yarn-debug.log*
yarn-error.log*
pnpm-debug.log*
lerna-debug.log*

node_modules
dist
dist-ssr
*.local

.vscode/*
!.vscode/extensions.json
.idea
.DS_Store
*.suo
*.ntvs*
*.njsproj
*.sln
*.sw?
EOF

cat << 'EOF' > README.md
# 🚀 React Hackathon Starter Kit

> Template chuẩn mực cho các cuộc thi Hackathon: **React 19 + TypeScript + Vite + Tailwind CSS + shadcn/ui + Zustand + React Router v7 + SharedWorker + ServiceWorker**.

## 🛠️ Khởi Chạy
```bash
npm install
npm run dev
```
EOF

chmod +x setup.sh 2>/dev/null || true

echo -e "\n${GREEN}${BOLD}======================================================${NC}"
echo -e "${GREEN}${BOLD}✅ DỰ ÁN REACT HACKATHON ĐÃ ĐƯỢC TẠO THÀNH CÔNG!${NC}"
echo -e "${GREEN}${BOLD}======================================================${NC}"
echo -e "👉 Để khởi chạy dự án:"
echo -e "   ${CYAN}cd \"$TARGET_DIR\"${NC}"
echo -e "   ${CYAN}npm run dev${NC}\n"
