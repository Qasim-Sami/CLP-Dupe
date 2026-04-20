# Project Context for Claude Code

This is a logistics/freight forwarding platform built with modern web technologies. The platform handles shipment tracking, customs clearance, customer management, and real-time collaboration between forwarders and shippers.

## Tech Stack

- **Frontend**: React 18.3.1 + TypeScript + Vite
- **UI Framework**: Tailwind CSS + shadcn/ui components
- **Backend**: Supabase (PostgreSQL + real-time subscriptions)
- **State Management**: React Query (@tanstack/react-query)
- **Routing**: React Router DOM v6
- **Maps**: Mapbox GL
- **Build Tool**: Vite 6.4.1

**Important**: This is primarily a TypeScript/JavaScript project. Always use TypeScript types, run type checks after multi-file changes, and prefer `.ts`/`.tsx` extensions.

## Working Style Preferences

### Mentoring vs. Implementation

**When I ask you to mentor or guide me**, give me step-by-step instructions to follow myself — **do NOT make the changes directly** unless I explicitly ask you to. I want to understand the "why" behind changes, not just receive code.

**When I ask for implementation**, you can make changes directly, but:
- Explain what you're doing and why
- Break complex changes into clear phases
- Use TodoWrite to track progress

### How to Know Which Mode I Want

- If I say "teach me", "guide me", "walk me through", or "help me understand" → **Mentor mode**
- If I say "implement", "fix", "add", or "build" → **Implementation mode**
- If unclear, ask me upfront: "Would you like me to make these changes directly, or guide you through them?"

## Code Quality Standards

### After File Changes

After **any** file deletion, removal, or refactoring task:
1. Always run `npx tsc --noEmit` to check for stale imports or type errors
2. Fix any issues before considering the task complete
3. Never leave broken imports, missing types, or cascading errors

### Multi-File Changes

When making changes across multiple files:
1. Run type checks after each logical group of changes
2. Verify the dev server still works (`npm run dev`)
3. Use TodoWrite to track progress through the changes
4. Mark each phase complete only after verification

### Data & API Changes

When replacing placeholder/demo data with real implementations:
1. Verify the actual API response shape first
2. Handle missing or optional fields gracefully
3. Add proper TypeScript types for responses
4. Test with real data before considering it complete

## Project Setup & Context

### Before Starting Scaffolding

Before starting project setup or scaffolding tasks:
- Always ask what has already been initialized or configured
- Do not assume a fresh start
- Check existing dependencies and configurations first

### Key Project Structure

```
src/
├── components/          # Reusable UI components
│   ├── ui/             # shadcn/ui components
│   ├── shipment/       # Shipment-specific components
│   ├── shipper/        # Shipper portal components
│   └── forwarder/      # Forwarder-specific components
├── pages/              # Route pages
├── layouts/            # Layout wrappers (ForwarderLayout, ShipperLayout)
├── hooks/              # Custom React hooks
├── integrations/       # External service integrations (Supabase)
├── types/              # TypeScript type definitions
└── config/             # Configuration files
```

## Mobile Responsiveness

This project uses a **mobile-first responsive design**:
- Breakpoint: 768px (`md` in Tailwind)
- Bottom navigation on mobile (< 768px)
- Sidebar on desktop (≥ 768px)
- Hamburger menu for full navigation access on mobile
- iOS safe area support via CSS env() variables

**When making UI changes:**
- Always consider mobile view (< 768px)
- Use Tailwind responsive prefixes (`md:`, `lg:`, etc.)
- Test touch targets (minimum 44px)
- Ensure no horizontal scroll on mobile

## Debugging Workflow

When I bring you debugging issues:

1. **Read the error carefully** - Don't jump to solutions
2. **Identify the exact file(s) and line(s)** involved
3. **Check for common issues**:
   - Stale imports after deletions
   - Missing TypeScript types
   - Incorrect API response assumptions
   - Cascading type errors from one change
4. **Explain what you think is wrong** BEFORE making changes
5. **Propose a minimal fix** that addresses the root cause
6. **Verify the fix** with type checks and build
7. **Summarize** what was wrong and what changed

## Current Features & Areas

### User Roles
- **Forwarder/Admin**: Full access to shipments, customers, customs, documents
- **Shipper**: Limited portal access to their own shipments and orders

### Key Features
- Shipment state machine (draft → ready for pickup → customs → delivered)
- Real-time tracking with maps
- Document requirements and uploads
- Customs case management with shareable links
- Customer management
- Batch operations
- Inbox/messaging (in development)

### Recent Work
- Mobile-responsive Shipments page with card-based view
- Bottom navigation with badge counts
- Hamburger menu for full sidebar access on mobile
- Mobile detail sheets for Customers and Shipments pages

## Communication Preferences

### When Blocked or Uncertain
- **Ask questions** rather than guessing
- Present multiple options if there are different approaches
- Explain trade-offs clearly

### Session Management
- Break large tasks into phases that can be completed independently
- Use TodoWrite to track multi-step work
- If approaching session limits, prioritize getting a working state before continuing

### Tool Usage
- Prefer specialized tools (Read, Edit, Write, Grep, Glob) over Bash for file operations
- Use Task agents for parallel exploration or research
- Run builds and type checks via Bash after code changes

## Testing & Validation

Before considering any feature complete:
1. Run `npm run build` to ensure production build works
2. Check `npx tsc --noEmit` for type errors
3. Test in both desktop and mobile viewports
4. Verify the dev server runs without errors
5. Check that no new console warnings were introduced

## What NOT to Do

❌ Don't make changes without reading the relevant files first
❌ Don't assume project state or configuration
❌ Don't skip type checking after changes
❌ Don't leave stale imports or broken references
❌ Don't add features beyond what was requested
❌ Don't commit changes unless explicitly asked
❌ Don't use force git operations without explicit permission

## Integration Considerations

### Supabase
- All data fetching goes through Supabase client
- Real-time subscriptions for badge counts
- Row-level security policies in place
- Use typed Supabase clients from `@/integrations/supabase/client`

### Authentication
- Not yet configured in detail
- Plan to support both forwarder and shipper portals

### Future Integrations (Discussed)
- Email: AWS SES (~$1/month) for transactional emails
- SMS: Twilio (~$50/month) for critical notifications
- In-app notifications: Supabase real-time (free)
- Telegram bot: For customer preference (free)
- ❌ WhatsApp Business API: Decided against due to cost/complexity

---

**Last Updated**: 2026-02-12
**Project Phase**: Active development - Mobile responsiveness complete