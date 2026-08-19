#!/bin/sh
# ==============================================================================
# 🚀 REACT HACKATHON FULL-STACK STARTER KIT SETUP SCRIPT (PNPM + TYPESCRIPT)
# ==============================================================================
# Cấu hình tính năng:
#  - MẶC ĐỊNH: React 19 + TypeScript + Vite + Tailwind CSS + shadcn/ui + Zustand + Router
#  - TUỲ CHỌN (Optional):
#      1. Shared Worker (Đồng bộ real-time nhiều Tab không cần backend)
#      2. Service Worker & PWA (Caching Offline, Push Notifications, Install App)
# ==============================================================================

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
MAGENTA='\033[0;35m'
BOLD='\033[1m'
NC='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
DEFAULT_TARGET="$SCRIPT_DIR"

printf "\n${CYAN}${BOLD}================================================================================${NC}\n"
printf "${CYAN}${BOLD}🚀 KHỞI TẠO DỰ ÁN REACT 19 + TYPESCRIPT + PNPM (HACKATHON STARTER KIT)${NC}\n"
printf "${CYAN}${BOLD}================================================================================${NC}\n\n"

# ------------------------------------------------------------------------------
# 1. Nhập đường dẫn dự án
# ------------------------------------------------------------------------------
if [ -n "$1" ]; then
  RAW_PATH="$1"
else
  printf "${YELLOW}${BOLD}1. Nhập đường dẫn thư mục dự án muốn tạo:${NC}\n"
  printf "👉 Nhấn ${CYAN}[Enter]${NC} để dùng mặc định: ${GREEN}%s${NC}\n" "$DEFAULT_TARGET"
  printf "Đường dẫn: "
  read USER_INPUT_PATH
  if [ -z "$USER_INPUT_PATH" ]; then
    RAW_PATH="$DEFAULT_TARGET"
  else
    RAW_PATH="$USER_INPUT_PATH"
  fi
fi

# Xử lý ký tự ~ thành $HOME nếu có
case "$RAW_PATH" in
  \~*) RAW_PATH="$HOME${RAW_PATH#\~}" ;;
esac

mkdir -p "$RAW_PATH"
TARGET_DIR="$(cd "$RAW_PATH" && pwd)"

# ------------------------------------------------------------------------------
# 2. Chọn các tính năng tuỳ chọn (Optional Features)
# ------------------------------------------------------------------------------
printf "\n${YELLOW}${BOLD}2. Chọn các tính năng nâng cao (Optional Features):${NC}\n"
printf "   ${GREEN}✓${NC} React 19 + TypeScript + Vite + Tailwind CSS + shadcn/ui + Zustand + Router (${BOLD}Mặc định${NC})\n\n"

# Option 1: Shared Worker
printf "👉 Bạn có muốn thêm ${CYAN}${BOLD}[Shared Worker]${NC} (Đồng bộ real-time nhiều Tab)? [Y/n]: "
read INPUT_SHARED_WORKER
case "$INPUT_SHARED_WORKER" in
  [nN][oO]|[nN])
    ENABLE_SHARED_WORKER="n"
    ;;
  *)
    ENABLE_SHARED_WORKER="y"
    ;;
esac

# Option 2: Service Worker
printf "👉 Bạn có muốn thêm ${CYAN}${BOLD}[Service Worker & PWA]${NC} (Offline Cache & Push Notifications)? [Y/n]: "
read INPUT_SERVICE_WORKER
case "$INPUT_SERVICE_WORKER" in
  [nN][oO]|[nN])
    ENABLE_SERVICE_WORKER="n"
    ;;
  *)
    ENABLE_SERVICE_WORKER="y"
    ;;
esac

printf "\n${MAGENTA}${BOLD}📋 Cấu hình đã chọn:${NC}\n"
printf " • Thư mục: ${GREEN}%s${NC}\n" "$TARGET_DIR"
printf " • Core Stack: React 19, TypeScript, Vite, Tailwind CSS, shadcn/ui, Zustand, React Router v7\n"
if [ "$ENABLE_SHARED_WORKER" = "y" ]; then
  printf " • Shared Worker: ${GREEN}BẬT (Enabled)${NC}\n"
else
  printf " • Shared Worker: ${YELLOW}TẮT (Disabled)${NC}\n"
fi
if [ "$ENABLE_SERVICE_WORKER" = "y" ]; then
  printf " • Service Worker & PWA: ${GREEN}BẬT (Enabled)${NC}\n"
else
  printf " • Service Worker & PWA: ${YELLOW}TẮT (Disabled)${NC}\n"
fi

printf "\n${CYAN}${BOLD}📋 TIẾN TRÌNH THỰC HIỆN TỪNG BƯỚC (ROADMAP):${NC}\n"
printf "  [1/9] 📦 Khởi tạo Project & Cấu hình pnpm (package.json, pnpm-workspace.yaml)\n"
printf "  [2/9] 📂 Thiết lập Cấu trúc Thư mục chuẩn (Folder Structure)\n"
printf "  [3/9] ⚙️  Cấu hình TypeScript & Vite Bundler (tsconfig, vite.config.ts)\n"
printf "  [4/9] 🎨 Thiết lập Tailwind CSS & Design System (index.css, CSS variables)\n"
printf "  [5/9] 🧩 Tích hợp shadcn/ui Components (Button, Card, Badge, Avatar)\n"
printf "  [6/9] 🗄️  Thiết lập Zustand Store (App Theme, Auth Store, Persist)\n"
printf "  [7/9] 🧭 Xây dựng Responsive Sidebar & Page Navigation (React Router v7)\n"
printf "  [8/9] ⚡ Tích hợp Web Workers (SharedWorker & ServiceWorker PWA)\n"
printf "  [9/9] 📥 Cài đặt Dependencies qua pnpm & Hoàn tất!\n\n"

cd "$TARGET_DIR"

# ------------------------------------------------------------------------------
# BƯỚC 1: Khởi tạo Project & Cấu hình pnpm
# ------------------------------------------------------------------------------
printf "${BLUE}${BOLD}▶️ [BƯỚC 1/9] 📦 Khởi tạo Project & Cấu hình pnpm...${NC}\n"
printf "   ↳ Tạo package.json và pnpm-workspace.yaml cho pnpm v11...\n"

cat << 'EOF' > pnpm-workspace.yaml
allowBuilds:
  esbuild: true
onlyBuiltDependencies:
  - esbuild
EOF

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
printf "   ${GREEN}✓ Hoàn tất cấu hình package.json & pnpm workspace.${NC}\n\n"

# ------------------------------------------------------------------------------
# BƯỚC 2: Cấu trúc thư mục (Folder Structure)
# ------------------------------------------------------------------------------
printf "${BLUE}${BOLD}▶️ [BƯỚC 2/9] 📂 Thiết lập Cấu trúc Thư mục chuẩn (Folder Structure)...${NC}\n"
printf "   ↳ Tạo src/components, src/stores, src/hooks, src/pages, src/routes, src/lib, public...\n"

mkdir -p src/assets src/components/common src/components/layout src/components/ui src/hooks src/lib src/pages src/routes src/stores src/types public
if [ "$ENABLE_SHARED_WORKER" = "y" ]; then
  mkdir -p src/workers
fi
printf "   ${GREEN}✓ Hoàn tất thiết lập cấu trúc thư mục.${NC}\n\n"

# ------------------------------------------------------------------------------
# BƯỚC 3: Cấu hình TypeScript & Vite Bundler
# ------------------------------------------------------------------------------
printf "${BLUE}${BOLD}▶️ [BƯỚC 3/9] ⚙️  Cấu hình TypeScript & Vite Bundler...${NC}\n"
printf "   ↳ Tạo vite.config.ts, tsconfig.json, tsconfig.app.json, tsconfig.node.json, index.html...\n"

# vite.config.ts
if [ "$ENABLE_SHARED_WORKER" = "y" ]; then
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
else
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
  server: {
    port: 3000,
    open: true,
  },
});
EOF
fi

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

# index.html
cat << 'EOF' > index.html
<!doctype html>
<html lang="vi" class="dark">
  <head>
    <meta charset="UTF-8" />
    <link rel="icon" type="image/svg+xml" href="/vite.svg" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Hackathon Starter | React 19 + TypeScript + Zustand + shadcn/ui</title>
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
printf "   ${GREEN}✓ Hoàn tất cấu hình TypeScript và Vite Bundler.${NC}\n\n"

# ------------------------------------------------------------------------------
# BƯỚC 4: Cấu hình Tailwind CSS & Design System
# ------------------------------------------------------------------------------
printf "${BLUE}${BOLD}▶️ [BƯỚC 4/9] 🎨 Thiết lập Tailwind CSS & Design System...${NC}\n"
printf "   ↳ Tạo tailwind.config.js, postcss.config.js, src/index.css (HSL Variables & Dark/Light mode)...\n"

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
printf "   ${GREEN}✓ Hoàn tất thiết lập Tailwind CSS & Design System.${NC}\n\n"

# ------------------------------------------------------------------------------
# BƯỚC 5: Tích hợp shadcn/ui Components
# ------------------------------------------------------------------------------
printf "${BLUE}${BOLD}▶️ [BƯỚC 5/9] 🧩 Tích hợp shadcn/ui Components...${NC}\n"
printf "   ↳ Tạo components.json, Button, Card, Badge, Avatar...\n"

# components.json
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
        warning:
          "border-transparent bg-amber-500/15 text-amber-600 dark:text-amber-400 border border-amber-500/20",
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
printf "   ${GREEN}✓ Hoàn tất tạo các components shadcn/ui.${NC}\n\n"

# ------------------------------------------------------------------------------
# BƯỚC 6: Thiết lập Zustand Stores
# ------------------------------------------------------------------------------
printf "${BLUE}${BOLD}▶️ [BƯỚC 6/9] 🗄️  Thiết lập Zustand Store & Types...${NC}\n"
printf "   ↳ Tạo types/index.ts, stores/appStore.ts (Theme & Sidebar), stores/authStore.ts...\n"

# Types
if [ "$ENABLE_SHARED_WORKER" = "y" ]; then
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
else
cat << 'EOF' > src/types/index.ts
export type Theme = "light" | "dark" | "system";

export interface User {
  id: string;
  name: string;
  email: string;
  avatar: string;
  role: "admin" | "hacker" | "viewer";
}
EOF
fi

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
printf "   ${GREEN}✓ Hoàn tất thiết lập Zustand Stores.${NC}\n\n"

# ------------------------------------------------------------------------------
# BƯỚC 7: Responsive Sidebar, Header & Page Navigation (Router v7)
# ------------------------------------------------------------------------------
printf "${BLUE}${BOLD}▶️ [BƯỚC 7/9] 🧭 Xây dựng Responsive Sidebar & Page Navigation...${NC}\n"
printf "   ↳ Tạo Header.tsx, Sidebar.tsx (căn giữa icon toggled), AppLayout.tsx, AppRoutes.tsx, Pages...\n"

# Header.tsx
if [ "$ENABLE_SHARED_WORKER" = "y" ]; then
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
else
cat << 'EOF' > src/components/layout/Header.tsx
import React from "react";
import { Menu, Moon, Sun } from "lucide-react";
import { useAppStore } from "@/stores/appStore";
import { useAuthStore } from "@/stores/authStore";
import { Button } from "@/components/ui/button";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Badge } from "@/components/ui/badge";

export const Header: React.FC = () => {
  const { theme, setTheme, toggleSidebar, setMobileSidebarOpen } = useAppStore();
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
fi

# Sidebar.tsx
cat << EOF > src/components/layout/Sidebar.tsx
import React from "react";
import { NavLink } from "react-router-dom";
import {
  LayoutDashboard,
  BarChart3,
  Settings,
  Flame,
  X,
  Sparkles,
  $([ "$ENABLE_SHARED_WORKER" = "y" ] && printf "Cpu,\n  ")$([ "$ENABLE_SERVICE_WORKER" = "y" ] && printf "Zap,\n  ")
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
  $([ "$ENABLE_SHARED_WORKER" = "y" ] && printf '{ title: "Shared Worker Sync", path: "/worker-sync", icon: Cpu, badge: "Multi-tab" },\n  ')$([ "$ENABLE_SERVICE_WORKER" = "y" ] && printf '{ title: "Service Worker & PWA", path: "/service-worker", icon: Zap, badge: "Offline/PWA" },\n  '){ title: "Analytics", path: "/analytics", icon: BarChart3 },
  { title: "Settings", path: "/settings", icon: Settings },
];

export const Sidebar: React.FC = () => {
  const { isSidebarCollapsed, isMobileSidebarOpen, setMobileSidebarOpen } = useAppStore();

  const renderNavLinks = (isMobile = false) => {
    const collapsed = isSidebarCollapsed && !isMobile;

    return (
      <div
        className={cn(
          "flex flex-col gap-2 py-4",
          collapsed ? "items-center px-2" : "px-3"
        )}
      >
        {navItems.map((item) => {
          const Icon = item.icon;
          return (
            <NavLink
              key={item.path}
              to={item.path}
              title={collapsed ? item.title : undefined}
              onClick={() => setMobileSidebarOpen(false)}
              className={({ isActive }) =>
                cn(
                  "group relative flex items-center rounded-xl text-sm font-medium transition-all duration-200",
                  collapsed
                    ? "h-11 w-11 justify-center p-0"
                    : "w-full gap-3 px-3.5 py-2.5",
                  isActive
                    ? "bg-primary text-primary-foreground shadow-md shadow-primary/25"
                    : "text-muted-foreground hover:bg-accent hover:text-foreground"
                )
              }
            >
              <Icon className="h-5 w-5 shrink-0 transition-transform duration-200 group-hover:scale-110" />

              {!collapsed && (
                <span className="truncate transition-opacity duration-200">
                  {item.title}
                </span>
              )}

              {item.badge && !collapsed && (
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
  };

  return (
    <>
      <aside
        className={cn(
          "hidden border-r bg-sidebar transition-all duration-300 ease-in-out lg:flex lg:flex-col",
          isSidebarCollapsed ? "w-20" : "w-64"
        )}
      >
        <div
          className={cn(
            "flex h-16 items-center border-b transition-all duration-300",
            isSidebarCollapsed ? "justify-center px-2" : "gap-3 px-5"
          )}
        >
          <div className="flex h-10 w-10 shrink-0 items-center justify-center rounded-xl bg-gradient-to-tr from-primary to-indigo-500 shadow-md shadow-primary/30">
            <Flame className="h-5 w-5 text-white" />
          </div>
          {!isSidebarCollapsed && (
            <div className="flex flex-col overflow-hidden">
              <span className="font-extrabold text-foreground tracking-tight truncate">
                FAST PROTOTYPE
              </span>
              <span className="text-[10px] text-muted-foreground truncate">
                Hackathon Edition
              </span>
            </div>
          )}
        </div>

        <div className="flex-1 overflow-y-auto">{renderNavLinks(false)}</div>

        {!isSidebarCollapsed && (
          <div className="p-4">
            <div className="rounded-xl border bg-gradient-to-br from-primary/10 via-background to-secondary p-3.5 text-center">
              <Sparkles className="mx-auto h-5 w-5 text-primary mb-1" />
              <p className="text-xs font-bold text-foreground">Hackathon Ready</p>
              <p className="text-[10px] text-muted-foreground mt-0.5">Zustand + shadcn/ui</p>
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
              <div className="flex items-center gap-2.5">
                <div className="flex h-9 w-9 items-center justify-center rounded-xl bg-primary text-white">
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
            <div className="flex-1 overflow-y-auto">{renderNavLinks(true)}</div>
          </div>
        </div>
      )}
    </>
  );
};
EOF

# AppLayout.tsx
cat << EOF > src/components/layout/AppLayout.tsx
import React from "react";
import { Outlet } from "react-router-dom";
import { Sidebar } from "./Sidebar";
import { Header } from "./Header";
$([ "$ENABLE_SHARED_WORKER" = "y" ] && printf 'import { useSharedWorker } from "@/hooks/useSharedWorker";\n')
$([ "$ENABLE_SERVICE_WORKER" = "y" ] && printf 'import { useServiceWorker } from "@/hooks/useServiceWorker";\nimport { RefreshCw, WifiOff } from "lucide-react";\nimport { Button } from "@/components/ui/button";\n')

export const AppLayout: React.FC = () => {
  $([ "$ENABLE_SHARED_WORKER" = "y" ] && printf 'useSharedWorker();\n  ')
  $([ "$ENABLE_SERVICE_WORKER" = "y" ] && printf 'const { isOnline, hasUpdate, updateServiceWorker } = useServiceWorker();\n  ')

  return (
    <div className="flex min-h-screen bg-background text-foreground">
      <Sidebar />
      <div className="flex flex-1 flex-col overflow-hidden">
        <Header />
        $([ "$ENABLE_SERVICE_WORKER" = "y" ] && printf '{!isOnline && (
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
        )}\n        ')<main className="flex-1 overflow-y-auto p-4 md:p-6 lg:p-8">
          <Outlet />
        </main>
      </div>
    </div>
  );
};
EOF

# Dashboard.tsx
cat << EOF > src/pages/Dashboard.tsx
import React from "react";
import {
  Activity,
  Boxes,
  Layers,
  Share2,
  Zap,
  $([ "$ENABLE_SHARED_WORKER" = "y" ] && printf 'Cpu,\n  Users,\n  ')
} from "lucide-react";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { useAuthStore } from "@/stores/authStore";
import { Link } from "react-router-dom";
$([ "$ENABLE_SHARED_WORKER" = "y" ] && printf 'import { useWorkerStore } from "@/stores/workerStore";\n')
$([ "$ENABLE_SERVICE_WORKER" = "y" ] && printf 'import { useServiceWorker } from "@/hooks/useServiceWorker";\n')

export const Dashboard: React.FC = () => {
  $([ "$ENABLE_SHARED_WORKER" = "y" ] && printf 'const { activeTabsCount, sharedCounter } = useWorkerStore();\n  ')
  $([ "$ENABLE_SERVICE_WORKER" = "y" ] && printf 'const { isOnline, cachedUrls } = useServiceWorker();\n  ')
  const { user } = useAuthStore();

  const stats = [
    $([ "$ENABLE_SHARED_WORKER" = "y" ] && printf '{
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
    },\n    ')
    $([ "$ENABLE_SERVICE_WORKER" = "y" ] && printf '{
      title: "Trạng Thái Mạng",
      value: isOnline ? "Online 🟢" : "Offline 🔴",
      desc: "PWA Service Worker Active",
      icon: Zap,
      color: "text-amber-500",
      bg: "bg-amber-500/10",
    },
    {
      title: "Cache Storage",
      value: `${cachedUrls.length} files`,
      desc: "Offline-first Cache",
      icon: Layers,
      color: "text-emerald-500",
      bg: "bg-emerald-500/10",
    },\n    ')
    {
      title: "Zustand State",
      value: "Active",
      desc: "Persist & DevTools Ready",
      icon: Layers,
      color: "text-emerald-500",
      bg: "bg-emerald-500/10",
    },
    {
      title: "shadcn/ui & Tailwind",
      value: "Ready",
      desc: "Modern Design System",
      icon: Zap,
      color: "text-indigo-500",
      bg: "bg-indigo-500/10",
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
            Template chuẩn React 19 + TypeScript + pnpm + Zustand + shadcn/ui được tối ưu hóa cho các cuộc thi Hackathon đòi hỏi tốc độ phát triển cực nhanh.
          </p>
          <div className="flex flex-wrap gap-3 pt-2">
            $([ "$ENABLE_SHARED_WORKER" = "y" ] && printf '<Link to="/worker-sync">
              <Button className="gap-2">
                <Cpu className="h-4 w-4" /> SharedWorker Multi-Tab
              </Button>
            </Link>\n            ')
            $([ "$ENABLE_SERVICE_WORKER" = "y" ] && printf '<Link to="/service-worker">
              <Button variant="secondary" className="gap-2">
                <Zap className="h-4 w-4" /> Service Worker & PWA
              </Button>
            </Link>\n            ')
            <Link to="/analytics">
              <Button variant="outline" className="gap-2">
                <Activity className="h-4 w-4" /> Xem Analytics
              </Button>
            </Link>
          </div>
        </div>
      </div>

      <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-4">
        {stats.slice(0, 4).map((item, idx) => {
          const Icon = item.icon;
          return (
            <Card key={idx} className="relative overflow-hidden border">
              <CardHeader className="flex flex-row items-center justify-between pb-2">
                <CardTitle className="text-sm font-medium text-muted-foreground">
                  {item.title}
                </CardTitle>
                <div className={\`rounded-xl p-2.5 \${item.bg}\`}>
                  <Icon className={\`h-4 w-4 \${item.color}\`} />
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
              Mọi thành phần đã cấu hình TypeScript strictly typed và sẵn sàng code ngay lập tức
            </CardDescription>
          </CardHeader>
          <CardContent className="space-y-3">
            {[
              { name: "pnpm & TypeScript", desc: "Quản lý gói siêu tốc, an toàn type-safe toàn bộ dự án." },
              { name: "Tailwind CSS & shadcn/ui", desc: "Design system chuẩn mực, Dark/Light mode, animations." },
              { name: "Zustand State Management", desc: "Quản lý state toàn cục nhẹ nhàng, hỗ trợ LocalStorage persist." },
              $([ "$ENABLE_SHARED_WORKER" = "y" ] && printf '{ name: "Shared Worker", desc: "Giao tiếp và đồng bộ state tức thời giữa nhiều tab trình duyệt." },\n              ')
              $([ "$ENABLE_SERVICE_WORKER" = "y" ] && printf '{ name: "Service Worker & PWA", desc: "Caching offline, push notifications, quản lý CacheStorage." },\n              ')
              { name: "React Router v7", desc: "Điều hướng trang, layout lồng nhau và 404 page." },
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
              <h4 className="text-xs font-bold uppercase tracking-wider text-primary">1. UI & Components</h4>
              <p className="text-xs text-muted-foreground">
                Tất cả các components shadcn/ui nằm trong <code>src/components/ui/</code>. Bạn có thể mở rộng tự do!
              </p>
            </div>

            <div className="rounded-xl border p-4 bg-muted/40 space-y-2">
              <h4 className="text-xs font-bold uppercase tracking-wider text-primary">2. State Management</h4>
              <p className="text-xs text-muted-foreground">
                Tạo thêm stores tại <code>src/stores/</code> để lưu trữ state nghiệp vụ với Zustand.
              </p>
            </div>
          </CardContent>
        </Card>
      </div>
    </div>
  );
};
EOF

# AnalyticsPage.tsx
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
          { title: "Độ sẵn sàng hệ thống", value: "99.9%", change: "High Availability", icon: ShieldCheck },
          { title: "Tải CPU Client", value: "< 0.5%", change: "Optimized render", icon: TrendingUp },
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

# SettingsPage.tsx
cat << EOF > src/pages/SettingsPage.tsx
import React from "react";
import { Moon, Sun, Laptop, Trash2 } from "lucide-react";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { useAppStore } from "@/stores/appStore";
$([ "$ENABLE_SHARED_WORKER" = "y" ] && printf 'import { useWorkerStore } from "@/stores/workerStore";\n')

export const SettingsPage: React.FC = () => {
  const { theme, setTheme } = useAppStore();
  $([ "$ENABLE_SHARED_WORKER" = "y" ] && printf 'const { clearMessages } = useWorkerStore();\n')

  $([ "$ENABLE_SERVICE_WORKER" = "y" ] && printf 'const handleClearCache = async () => {
    if ("caches" in window) {
      const keys = await caches.keys();
      await Promise.all(keys.map((k) => caches.delete(k)));
      alert("Đã xóa toàn bộ Service Worker Caches thành công!");
    }
  };\n  ')

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
          <CardDescription>Xóa dữ liệu bộ nhớ cục bộ hoặc làm mới cache.</CardDescription>
        </CardHeader>
        <CardContent className="space-y-4">
          $([ "$ENABLE_SHARED_WORKER" = "y" ] && printf '<div className="flex items-center justify-between rounded-xl border p-4">
            <div>
              <p className="text-sm font-semibold">Xóa Lịch Sử Tin Nhắn Worker</p>
              <p className="text-xs text-muted-foreground">Xóa toàn bộ log cross-tab broadcast hiện tại.</p>
            </div>
            <Button variant="outline" size="sm" onClick={clearMessages} className="gap-1.5 text-destructive">
              <Trash2 className="h-4 w-4" /> Xóa Log
            </Button>
          </div>\n          ')
          $([ "$ENABLE_SERVICE_WORKER" = "y" ] && printf '<div className="flex items-center justify-between rounded-xl border p-4">
            <div>
              <p className="text-sm font-semibold">Xóa Cache Service Worker</p>
              <p className="text-xs text-muted-foreground">Làm mới dữ liệu offline cache của trình duyệt.</p>
            </div>
            <Button variant="outline" size="sm" onClick={handleClearCache} className="gap-1.5">
              <Trash2 className="h-4 w-4" /> Xóa Cache SW
            </Button>
          </div>\n          ')
          <div className="flex items-center justify-between rounded-xl border p-4">
            <div>
              <p className="text-sm font-semibold">Xóa LocalStorage App</p>
              <p className="text-xs text-muted-foreground">Đặt lại toàn bộ trạng thái theme và user auth về mặc định.</p>
            </div>
            <Button variant="outline" size="sm" onClick={() => { localStorage.clear(); window.location.reload(); }} className="gap-1.5 text-destructive">
              <Trash2 className="h-4 w-4" /> Reset LocalStorage
            </Button>
          </div>
        </CardContent>
      </Card>
    </div>
  );
};
EOF

# NotFound.tsx
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

# AppRoutes.tsx
cat << EOF > src/routes/AppRoutes.tsx
import React from "react";
import { createBrowserRouter, RouterProvider } from "react-router-dom";
import { AppLayout } from "@/components/layout/AppLayout";
import { Dashboard } from "@/pages/Dashboard";
$([ "$ENABLE_SHARED_WORKER" = "y" ] && printf 'import { WorkerSyncPage } from "@/pages/WorkerSyncPage";\n')
$([ "$ENABLE_SERVICE_WORKER" = "y" ] && printf 'import { ServiceWorkerPage } from "@/pages/ServiceWorkerPage";\n')
import { AnalyticsPage } from "@/pages/AnalyticsPage";
import { SettingsPage } from "@/pages/SettingsPage";
import { NotFound } from "@/pages/NotFound";

const router = createBrowserRouter([
  {
    path: "/",
    element: <AppLayout />,
    children: [
      { index: true, element: <Dashboard /> },
      $([ "$ENABLE_SHARED_WORKER" = "y" ] && printf '{ path: "worker-sync", element: <WorkerSyncPage /> },\n      ')
      $([ "$ENABLE_SERVICE_WORKER" = "y" ] && printf '{ path: "service-worker", element: <ServiceWorkerPage /> },\n      ')
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

# App.tsx & main.tsx
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
pnpm-debug.log*

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
# 🚀 React Hackathon Starter Kit (pnpm + TypeScript)

> Template chuẩn mực cho các cuộc thi Hackathon: **React 19 + TypeScript + pnpm + Vite + Tailwind CSS + shadcn/ui + Zustand + React Router v7**.

## 🛠️ Khởi Chạy
```bash
# 1. Cài đặt dependencies với pnpm
pnpm install

# 2. Khởi động Dev Server
pnpm dev

# 3. Build sản phẩm
pnpm run build
```
EOF
printf "   ${GREEN}✓ Hoàn tất xây dựng Sidebar, Header và Page Navigation.${NC}\n\n"

# ------------------------------------------------------------------------------
# BƯỚC 8: Tích hợp Web Workers (nếu được bật)
# ------------------------------------------------------------------------------
printf "${BLUE}${BOLD}▶️ [BƯỚC 8/9] ⚡ Tích hợp Web Workers (Shared Worker & Service Worker PWA)...${NC}\n"

if [ "$ENABLE_SHARED_WORKER" = "y" ]; then
  printf "   ↳ [Shared Worker] Tạo src/workers/shared-worker.ts, src/hooks/useSharedWorker.ts, WorkerSyncPage.tsx...\n"
  
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
  printf "   ${GREEN}✓ Hoàn tất cấu hình Shared Worker.${NC}\n"
fi

if [ "$ENABLE_SERVICE_WORKER" = "y" ]; then
  printf "   ↳ [Service Worker] Tạo public/sw.js, src/hooks/useServiceWorker.ts, ServiceWorkerPage.tsx...\n"
  
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

  const url = new URL(event.request.url);

  event.respondWith(
    caches.match(event.request).then((cachedResponse) => {
      const fetchPromise = fetch(event.request)
        .then((networkResponse) => {
          if (
            networkResponse &&
            networkResponse.status === 200 &&
            (url.protocol === "http:" || url.protocol === "https:")
          ) {
            const responseClone = networkResponse.clone();
            caches.open(CACHE_NAME).then((cache) => {
              cache.put(event.request, responseClone);
            });
          }
          return networkResponse;
        })
        .catch(() => {
          if (cachedResponse) return cachedResponse;
          if (event.request.headers.get("accept")?.includes("text/html")) {
            return caches.match("/index.html");
          }
        });

      return cachedResponse || fetchPromise;
    })
  );
});

self.addEventListener("push", (event) => {
  const data = event.data ? event.data.json() : { title: "Hackathon Alert", body: "Thông báo push từ Service Worker!" };
  const options = {
    body: data.body,
    icon: "/vite.svg",
    badge: "/vite.svg",
    data: { url: "/" },
  };

  event.waitUntil(
    self.registration.showNotification(data.title, options)
  );
});

self.addEventListener("notificationclick", (event) => {
  event.notification.close();
  event.waitUntil(
    self.clients.matchAll({ type: "window" }).then((clientList) => {
      for (const client of clientList) {
        if (client.url === "/" && "focus" in client) {
          return client.focus();
        }
      }
      if (self.clients.openWindow) {
        return self.clients.openWindow("/");
      }
    })
  );
});
EOF

cat << 'EOF' > src/hooks/useServiceWorker.ts
import { useState, useEffect, useCallback } from "react";

export function useServiceWorker() {
  const [isRegistered, setIsRegistered] = useState(false);
  const [registration, setRegistration] = useState<ServiceWorkerRegistration | null>(null);
  const [isOnline, setIsOnline] = useState(navigator.onLine);
  const [hasUpdate, setHasUpdate] = useState(false);
  const [deferredPrompt, setDeferredPrompt] = useState<any>(null);
  const [notificationPermission, setNotificationPermission] = useState<NotificationPermission>(
    typeof Notification !== "undefined" ? Notification.permission : "default"
  );
  const [cachedUrls, setCachedUrls] = useState<string[]>([]);

  const refreshCacheList = useCallback(async () => {
    if ("caches" in window) {
      try {
        const cache = await caches.open("hackathon-cache-v1");
        const requests = await cache.keys();
        setCachedUrls(requests.map((req) => req.url));
      } catch (err) {
        console.error("Lỗi đọc cache:", err);
      }
    }
  }, []);

  useEffect(() => {
    const handleOnline = () => setIsOnline(true);
    const handleOffline = () => setIsOnline(false);

    window.addEventListener("online", handleOnline);
    window.addEventListener("offline", handleOffline);

    const handleBeforeInstall = (e: Event) => {
      e.preventDefault();
      setDeferredPrompt(e);
    };
    window.addEventListener("beforeinstallprompt", handleBeforeInstall);

    if ("serviceWorker" in navigator) {
      navigator.serviceWorker
        .register("/sw.js")
        .then((reg) => {
          setIsRegistered(true);
          setRegistration(reg);
          refreshCacheList();

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
      window.removeEventListener("beforeinstallprompt", handleBeforeInstall);
    };
  }, [refreshCacheList]);

  const installPWA = async () => {
    if (deferredPrompt) {
      deferredPrompt.prompt();
      const choiceResult = await deferredPrompt.userChoice;
      if (choiceResult.outcome === "accepted") {
        setDeferredPrompt(null);
      }
    } else {
      alert("Trình duyệt hiện tại đã cài đặt app hoặc không hỗ trợ PWA prompt!");
    }
  };

  const requestNotificationPermission = async () => {
    if ("Notification" in window) {
      const permission = await Notification.requestPermission();
      setNotificationPermission(permission);
      return permission;
    }
    return "denied";
  };

  const sendTestNotification = async (title = "Hackathon Alert 🚀", body = "Thông báo push từ Service Worker hoạt động hoàn hảo!") => {
    if ("Notification" in window) {
      let perm = Notification.permission;
      if (perm !== "granted") {
        perm = await requestNotificationPermission();
      }

      if (perm === "granted" && registration) {
        registration.showNotification(title, {
          body,
          icon: "/vite.svg",
          badge: "/vite.svg",
        } as NotificationOptions);
      } else {
        alert("Vui lòng cấp quyền thông báo cho trình duyệt!");
      }
    }
  };

  const addUrlToCache = async (url: string) => {
    if ("caches" in window && url.trim()) {
      try {
        const cache = await caches.open("hackathon-cache-v1");
        await cache.add(url.trim());
        await refreshCacheList();
        return true;
      } catch (err) {
        console.error("Lỗi khi thêm URL vào cache:", err);
        alert("Không thể cache URL này (có thể do CORS hoặc URL không hợp lệ).");
        return false;
      }
    }
    return false;
  };

  const deleteCacheItem = async (url: string) => {
    if ("caches" in window) {
      const cache = await caches.open("hackathon-cache-v1");
      await cache.delete(url);
      await refreshCacheList();
    }
  };

  const clearAllCache = async () => {
    if ("caches" in window) {
      const keys = await caches.keys();
      await Promise.all(keys.map((k) => caches.delete(k)));
      setCachedUrls([]);
      alert("Đã xóa toàn bộ Cache Storage!");
    }
  };

  const checkForUpdate = async () => {
    if (registration) {
      await registration.update();
      alert("Đã kiểm tra Service Worker. Bạn đang dùng phiên bản mới nhất!");
    }
  };

  const updateServiceWorker = () => {
    window.location.reload();
  };

  return {
    isRegistered,
    registration,
    isOnline,
    hasUpdate,
    canInstallPWA: !!deferredPrompt,
    notificationPermission,
    cachedUrls,
    installPWA,
    requestNotificationPermission,
    sendTestNotification,
    addUrlToCache,
    deleteCacheItem,
    clearAllCache,
    refreshCacheList,
    checkForUpdate,
    updateServiceWorker,
  };
}
EOF

cat << 'EOF' > src/pages/ServiceWorkerPage.tsx
import React, { useState } from "react";
import {
  Wifi,
  WifiOff,
  Bell,
  Download,
  Database,
  Trash2,
  Plus,
  RefreshCw,
  CheckCircle2,
  HardDrive,
  ShieldCheck,
  Globe,
} from "lucide-react";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { useServiceWorker } from "@/hooks/useServiceWorker";

export const ServiceWorkerPage: React.FC = () => {
  const {
    isRegistered,
    isOnline,
    canInstallPWA,
    notificationPermission,
    cachedUrls,
    installPWA,
    sendTestNotification,
    addUrlToCache,
    deleteCacheItem,
    clearAllCache,
    refreshCacheList,
    checkForUpdate,
  } = useServiceWorker();

  const [customTitle, setCustomTitle] = useState("Hackathon Demo 🚀");
  const [customBody, setCustomBody] = useState("Service Worker push notification đang hoạt động mượt mà!");
  const [newCacheUrl, setNewCacheUrl] = useState("");
  const [fetchTestResult, setFetchTestResult] = useState<{ url: string; time: number; status: string; fromCache: boolean } | null>(null);
  const [isTestingFetch, setIsTestingFetch] = useState(false);

  const handleSendNotification = (e: React.FormEvent) => {
    e.preventDefault();
    sendTestNotification(customTitle, customBody);
  };

  const handleAddCache = async (e: React.FormEvent) => {
    e.preventDefault();
    if (newCacheUrl.trim()) {
      await addUrlToCache(newCacheUrl.trim());
      setNewCacheUrl("");
    }
  };

  const handleTestCacheFetch = async () => {
    setIsTestingFetch(true);
    const testUrl = "/vite.svg";
    const startTime = performance.now();
    try {
      const response = await fetch(testUrl);
      const endTime = performance.now();
      const time = Math.round((endTime - startTime) * 100) / 100;
      setFetchTestResult({
        url: testUrl,
        time,
        status: `${response.status} ${response.statusText}`,
        fromCache: time < 15,
      });
    } catch (err) {
      setFetchTestResult({
        url: testUrl,
        time: 0,
        status: "Lỗi kết nối",
        fromCache: false,
      });
    } finally {
      setIsTestingFetch(false);
    }
  };

  return (
    <div className="space-y-6">
      <div className="flex flex-col gap-2 sm:flex-row sm:items-center sm:justify-between">
        <div>
          <h1 className="text-2xl sm:text-3xl font-extrabold tracking-tight">
            Service Worker & PWA Playground ⚡
          </h1>
          <p className="text-sm text-muted-foreground">
            Khám phá tính năng Caching Offline, Push Notification, PWA Installation và Quản lý Cache Storage.
          </p>
        </div>

        <div className="flex items-center gap-2">
          <Button variant="outline" size="sm" onClick={checkForUpdate} className="gap-1.5">
            <RefreshCw className="h-4 w-4" /> Kiểm tra cập nhật
          </Button>
          {canInstallPWA && (
            <Button size="sm" onClick={installPWA} className="gap-1.5 bg-gradient-to-r from-primary to-indigo-500 text-white">
              <Download className="h-4 w-4" /> Cài đặt App (PWA)
            </Button>
          )}
        </div>
      </div>

      <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-4">
        <Card className="border">
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-xs font-semibold text-muted-foreground uppercase">Service Worker</CardTitle>
            <ShieldCheck className="h-4 w-4 text-primary" />
          </CardHeader>
          <CardContent>
            <div className="flex items-center gap-2">
              <Badge variant={isRegistered ? "success" : "destructive"}>
                {isRegistered ? "Đã Kích Hoạt (Active)" : "Chưa Đăng Ký"}
              </Badge>
            </div>
            <p className="text-xs text-muted-foreground mt-2">Scope: <code>/</code></p>
          </CardContent>
        </Card>

        <Card className="border">
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-xs font-semibold text-muted-foreground uppercase">Trạng Thái Mạng</CardTitle>
            {isOnline ? <Wifi className="h-4 w-4 text-emerald-500" /> : <WifiOff className="h-4 w-4 text-destructive" />}
          </CardHeader>
          <CardContent>
            <div className="flex items-center gap-2">
              <Badge variant={isOnline ? "success" : "destructive"}>
                {isOnline ? "Đang Online 🟢" : "Đang Offline 🔴"}
              </Badge>
            </div>
            <p className="text-xs text-muted-foreground mt-2">
              {isOnline ? "App kết nối mạng bình thường" : "App đang chạy từ Service Worker cache"}
            </p>
          </CardContent>
        </Card>

        <Card className="border">
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-xs font-semibold text-muted-foreground uppercase">Quyền Push Notification</CardTitle>
            <Bell className="h-4 w-4 text-purple-500" />
          </CardHeader>
          <CardContent>
            <Badge variant={notificationPermission === "granted" ? "success" : "warning"}>
              {notificationPermission.toUpperCase()}
            </Badge>
            <p className="text-xs text-muted-foreground mt-2">Local & Web Push Ready</p>
          </CardContent>
        </Card>

        <Card className="border">
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-xs font-semibold text-muted-foreground uppercase">Tài nguyên trong Cache</CardTitle>
            <Database className="h-4 w-4 text-blue-500" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-black">{cachedUrls.length} files</div>
            <p className="text-xs text-muted-foreground mt-1">Stored in CacheStorage</p>
          </CardContent>
        </Card>
      </div>

      <div className="grid gap-6 lg:grid-cols-2">
        <Card className="border shadow-sm">
          <CardHeader>
            <CardTitle className="flex items-center gap-2">
              <Bell className="h-5 w-5 text-primary" />
              Thử Nghiệm Push Notifications
            </CardTitle>
            <CardDescription>
              Service Worker có thể hiển thị thông báo hệ thống ngay cả khi tab ở chế độ nền.
            </CardDescription>
          </CardHeader>
          <CardContent>
            <form onSubmit={handleSendNotification} className="space-y-4">
              <div>
                <label className="text-xs font-semibold text-muted-foreground block mb-1">Tiêu đề thông báo</label>
                <input
                  type="text"
                  value={customTitle}
                  onChange={(e) => setCustomTitle(e.target.value)}
                  className="flex h-10 w-full rounded-lg border border-input bg-background px-3 py-2 text-sm focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring"
                />
              </div>

              <div>
                <label className="text-xs font-semibold text-muted-foreground block mb-1">Nội dung thông báo</label>
                <textarea
                  rows={2}
                  value={customBody}
                  onChange={(e) => setCustomBody(e.target.value)}
                  className="flex w-full rounded-lg border border-input bg-background px-3 py-2 text-sm focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring"
                />
              </div>

              <div className="flex items-center justify-between pt-2">
                <Badge variant="outline" className="text-xs">
                  Trạng thái: {notificationPermission === "granted" ? "Đã sẵn sàng" : "Chưa cấp quyền"}
                </Badge>
                <Button type="submit" className="gap-2">
                  <Bell className="h-4 w-4" /> Bắn Notification Test
                </Button>
              </div>
            </form>
          </CardContent>
        </Card>

        <Card className="border shadow-sm">
          <CardHeader>
            <CardTitle className="flex items-center gap-2">
              <HardDrive className="h-5 w-5 text-primary" />
              Kiểm Tra Tốc Độ Tải Từ Cache
            </CardTitle>
            <CardDescription>
              Kiểm tra khả năng tải tài nguyên tức thì (0 - 5ms) từ CacheStorage mà không cần internet.
            </CardDescription>
          </CardHeader>
          <CardContent className="space-y-4">
            <div className="rounded-xl border p-4 bg-muted/30 flex items-center justify-between">
              <div>
                <p className="text-sm font-semibold">Tài nguyên thử nghiệm: <code>/vite.svg</code></p>
                <p className="text-xs text-muted-foreground mt-0.5">Tải tài nguyên được Service Worker precache</p>
              </div>
              <Button onClick={handleTestCacheFetch} disabled={isTestingFetch} size="sm" variant="secondary" className="gap-1.5">
                <RefreshCw className={`h-4 w-4 ${isTestingFetch ? "animate-spin" : ""}`} /> Thử Tải Ngay
              </Button>
            </div>

            {fetchTestResult && (
              <div className="rounded-xl border p-4 bg-accent/40 space-y-2 text-xs">
                <div className="flex items-center justify-between font-bold">
                  <span>Kết quả phản hồi:</span>
                  <Badge variant={fetchTestResult.fromCache ? "success" : "default"}>
                    {fetchTestResult.fromCache ? "Cache Hit ⚡" : "Network Response"}
                  </Badge>
                </div>
                <div className="grid grid-cols-2 gap-2 text-muted-foreground pt-1">
                  <div>URL: <b className="text-foreground">{fetchTestResult.url}</b></div>
                  <div>Thời gian tải: <b className="text-foreground text-emerald-500 font-mono">{fetchTestResult.time} ms</b></div>
                  <div>HTTP Status: <b className="text-foreground">{fetchTestResult.status}</b></div>
                  <div>Nguồn: <b className="text-foreground">{fetchTestResult.fromCache ? "CacheStorage (Offline Safe)" : "HTTP Network"}</b></div>
                </div>
              </div>
            )}

            <div className="rounded-xl border p-3.5 bg-primary/5 text-xs text-muted-foreground flex items-start gap-2">
              <CheckCircle2 className="h-4 w-4 text-primary shrink-0 mt-0.5" />
              <span>
                <b>Mẹo Hackathon:</b> Mở Chrome DevTools (F12) → tab <b>Network</b> → chọn <b>Offline</b> và thử tải lại trang! Ứng dụng vẫn chạy mượt mà nhờ Service Worker.
              </span>
            </div>
          </CardContent>
        </Card>
      </div>

      <Card className="border shadow-sm">
        <CardHeader className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-2">
          <div>
            <CardTitle className="flex items-center gap-2">
              <Database className="h-5 w-5 text-primary" />
              Cache Storage Explorer (hackathon-cache-v1)
            </CardTitle>
            <CardDescription>
              Xem danh sách toàn bộ tài nguyên được lưu vào bộ nhớ đệm của Service Worker
            </CardDescription>
          </div>
          <div className="flex items-center gap-2">
            <Button size="sm" variant="outline" onClick={refreshCacheList} className="gap-1.5">
              <RefreshCw className="h-3.5 w-3.5" /> Làm mới
            </Button>
            <Button size="sm" variant="destructive" onClick={clearAllCache} className="gap-1.5">
              <Trash2 className="h-3.5 w-3.5" /> Xóa tất cả
            </Button>
          </div>
        </CardHeader>

        <CardContent className="space-y-4">
          <form onSubmit={handleAddCache} className="flex gap-2">
            <input
              type="text"
              value={newCacheUrl}
              onChange={(e) => setNewCacheUrl(e.target.value)}
              placeholder="Nhập đường dẫn muốn thêm vào cache (vd: /vite.svg hoặc URL hình ảnh)..."
              className="flex h-10 w-full rounded-lg border border-input bg-background px-3 py-2 text-sm focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring"
            />
            <Button type="submit" className="gap-1.5 shrink-0">
              <Plus className="h-4 w-4" /> Thêm vào Cache
            </Button>
          </form>

          <div className="rounded-xl border divide-y max-h-72 overflow-y-auto">
            {cachedUrls.length === 0 ? (
              <div className="p-6 text-center text-xs text-muted-foreground">
                Chưa có tài nguyên nào trong cache.
              </div>
            ) : (
              cachedUrls.map((url, idx) => (
                <div key={idx} className="flex items-center justify-between p-3 text-xs hover:bg-accent/40 transition-colors">
                  <div className="flex items-center gap-2 truncate pr-4">
                    <Globe className="h-4 w-4 text-primary shrink-0" />
                    <span className="font-mono text-foreground truncate">{url}</span>
                  </div>
                  <Button
                    size="sm"
                    variant="ghost"
                    onClick={() => deleteCacheItem(url)}
                    className="h-7 text-xs text-destructive hover:text-destructive hover:bg-destructive/10 shrink-0"
                  >
                    <Trash2 className="h-3.5 w-3.5 mr-1" /> Xóa
                  </Button>
                </div>
              ))
            )}
          </div>
        </CardContent>
      </Card>
    </div>
  );
};
EOF
  printf "   ${GREEN}✓ Hoàn tất cấu hình Service Worker & PWA.${NC}\n"
fi

if [ "$ENABLE_SHARED_WORKER" != "y" ] && [ "$ENABLE_SERVICE_WORKER" != "y" ]; then
  printf "   ↳ Bỏ qua cấu hình Web Workers theo lựa chọn của bạn.\n"
fi
printf "\n"

# ------------------------------------------------------------------------------
# BƯỚC 9: Cài đặt dependencies qua pnpm
# ------------------------------------------------------------------------------
printf "${BLUE}${BOLD}▶️ [BƯỚC 9/9] 📥 Cài đặt Dependencies qua pnpm...${NC}\n"
printf "   ↳ Đang tải và liên kết các package với pnpm v11...\n\n"

if command -v pnpm >/dev/null 2>&1; then
  pnpm install
else
  printf "${YELLOW}⚠️  pnpm chưa có sẵn, sử dụng npx pnpm...${NC}\n"
  npx -y pnpm install
fi

chmod +x setup.sh 2>/dev/null || true

printf "\n${GREEN}${BOLD}================================================================================${NC}\n"
printf "${GREEN}${BOLD}✅ DỰ ÁN REACT HACKATHON ĐÃ ĐƯỢC TẠO THÀNH CÔNG!${NC}\n"
printf "${GREEN}${BOLD}================================================================================${NC}\n\n"

printf "${CYAN}${BOLD}🚀 KHỞI ĐỘNG DỰ ÁN NGAY:${NC}\n"
printf "   ${CYAN}cd \"%s\"${NC}\n" "$TARGET_DIR"
printf "   ${CYAN}pnpm dev${NC}\n\n"

printf "${MAGENTA}${BOLD}📖 HƯỚNG DẪN TỪNG BƯỚC SỬ DỤNG VÀ PHÁT TRIỂN (DEVELOPER GUIDE):${NC}\n"
printf "%s\n" "--------------------------------------------------------------------------------"
printf " 1. ${BOLD}📂 Cấu trúc thư mục (Folder Structure):${NC}\n"
printf "    • ${CYAN}src/components/ui/${NC}    : Các UI primitives chuẩn shadcn/ui (Button, Card, Badge, Avatar...)\n"
printf "    • ${CYAN}src/components/layout/${NC}: Header, Sidebar (toggled responsive), AppLayout\n"
printf "    • ${CYAN}src/stores/${NC}           : Quản lý state toàn cục với Zustand (appStore, authStore...)\n"
printf "    • ${CYAN}src/pages/${NC}            : Các trang giao diện (Dashboard, Analytics, Settings...)\n"
printf "    • ${CYAN}src/routes/${NC}           : Cấu hình điều hướng với React Router v7 (AppRoutes.tsx)\n"
printf "    • ${CYAN}src/hooks/${NC}            : Custom hooks (useSharedWorker, useServiceWorker...)\n"
printf "    • ${CYAN}src/lib/utils.ts${NC}       : Hàm cn() nối class Tailwind CSS và format dữ liệu\n"
printf "    • ${CYAN}public/${NC}              : Chứa file tĩnh & Service Worker (sw.js)\n\n"

printf " 2. ${BOLD}🗄️ Quản lý State với Zustand:${NC}\n"
printf "    • Đọc/ghi state: ${CYAN}const { theme, setTheme } = useAppStore();${NC}\n"
printf "    • Thêm store mới: Tạo file tại ${CYAN}src/stores/myStore.ts${NC} bằng hàm ${CYAN}create()${NC} của Zustand.\n\n"

printf " 3. ${BOLD}🧭 Thêm Trang mới & Cập nhật Sidebar:${NC}\n"
printf "    • Bước 1: Tạo component trang tại ${CYAN}src/pages/MyPage.tsx${NC}\n"
printf "    • Bước 2: Khai báo route trong ${CYAN}src/routes/AppRoutes.tsx${NC}\n"
printf "    • Bước 3: Thêm item vào danh sách ${CYAN}navItems${NC} trong ${CYAN}src/components/layout/Sidebar.tsx${NC}\n\n"

if [ "$ENABLE_SHARED_WORKER" = "y" ]; then
printf " 4. ${BOLD}⚡ Đồng bộ Đa Tab (Shared Worker):${NC}\n"
printf "    • Gọi ${CYAN}const { sharedCounter, incrementCounter } = useSharedWorker();${NC}\n"
printf "    • Mọi thay đổi dữ liệu sẽ được phát thanh (broadcast) đồng thời tới tất cả tab đang mở!\n\n"
fi

if [ "$ENABLE_SERVICE_WORKER" = "y" ]; then
printf " 5. ${BOLD}📲 PWA Offline & Push Notification (Service Worker):${NC}\n"
printf "    • Gọi ${CYAN}const { isOnline, sendTestNotification } = useServiceWorker();${NC}\n"
printf "    • Quản lý bộ nhớ đệm CacheStorage và bắn notification hệ thống dễ dàng.\n\n"
fi

printf " 6. ${BOLD}🎨 Tùy biến Giao diện (Tailwind CSS & shadcn/ui):${NC}\n"
printf "    • Tùy chỉnh màu sắc CSS Variables trong ${CYAN}src/index.css${NC} và ${CYAN}tailwind.config.js${NC}\n"
printf "    • Hệ thống tự động đồng bộ chế độ Dark/Light mode theo Zustand store.\n"
printf "%s\n\n" "--------------------------------------------------------------------------------"
