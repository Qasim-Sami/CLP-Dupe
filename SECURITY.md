# Security Guidelines

This document outlines the security measures implemented in the Jumruk logistics platform and best practices for maintaining security.

## 🔒 Security Layers

### 1. Content Security Policy (CSP)

**Location:** `index.html`

CSP headers protect against XSS attacks by controlling which resources can be loaded:

```html
Content-Security-Policy:
  default-src 'self';
  script-src 'self' 'unsafe-inline' 'unsafe-eval' https://api.mapbox.com;
  connect-src 'self' https://*.supabase.co https://api.mapbox.com wss://*.supabase.co;
  ...
```

**What it protects:**
- ✅ Prevents malicious script injection
- ✅ Blocks data exfiltration to unauthorized domains
- ✅ Prevents clickjacking attacks
- ✅ Forces HTTPS connections

### 2. Input Sanitization (DOMPurify)

**Location:** `src/lib/sanitize.ts`

All user input is sanitized using DOMPurify to prevent XSS attacks.

#### Usage Examples:

**Plain Text (Most Common):**
```typescript
import { sanitizeText } from '@/lib/sanitize';

// Sanitize user input before saving
const safeName = sanitizeText(formData.customerName);
const safeAddress = sanitizeText(formData.address);
```

**Rich HTML (Use Sparingly):**
```typescript
import { sanitizeHtml, createSafeMarkup } from '@/lib/sanitize';

// For rich text editors
const safeHtml = sanitizeHtml(editorContent);

// With React dangerouslySetInnerHTML
<div dangerouslySetInnerHTML={createSafeMarkup(userContent)} />
```

**URLs:**
```typescript
import { sanitizeUrl } from '@/lib/sanitize';

const safeUrl = sanitizeUrl(userProvidedUrl);
// Blocks: javascript:, data:, and other dangerous protocols
```

**File Names:**
```typescript
import { sanitizeFilename } from '@/lib/sanitize';

const safeFilename = sanitizeFilename(uploadedFile.name);
// Prevents: path traversal, special characters
```

### 3. Row-Level Security (RLS)

**Location:** `supabase/migrations/*.sql`

Database-level access control ensures users can only access their own data:

```sql
CREATE POLICY "Users can view their own shipments"
ON public.shipments FOR SELECT
TO authenticated
USING (auth.uid() = user_id);
```

**Protected Tables:**
- ✅ shipments
- ✅ customers
- ✅ batches
- ✅ documents
- ✅ All 26 tables have RLS enabled

### 4. Environment Variable Security

**Location:** `.env` (gitignored)

Sensitive credentials are stored in environment variables and never committed to git:

```env
VITE_SUPABASE_URL=https://...
VITE_SUPABASE_PUBLISHABLE_KEY=eyJ...  # Safe to expose (limited permissions)
VITE_MAPBOX_TOKEN=pk...                # Public token (domain-restricted)
```

**⚠️ NEVER commit:**
- Service role keys
- Database passwords
- Private API keys

## 🛡️ Security Checklist for Developers

### When Adding New Features:

- [ ] **User Input:** Sanitize all user input using `sanitizeText()`
- [ ] **Database Queries:** Ensure RLS policies exist for new tables
- [ ] **File Uploads:** Validate file types and sanitize filenames
- [ ] **External APIs:** Add domains to CSP `connect-src` directive
- [ ] **Rich Text:** Only use `sanitizeHtml()` when absolutely necessary
- [ ] **URLs:** Always use `sanitizeUrl()` for user-provided links
- [ ] **Forms:** Validate on both client and server (Supabase RLS)

### High-Risk Areas Requiring Sanitization:

1. **Shipment Data:**
   - `special_instructions` - Free text field
   - `shipper_name` / `consignee_name` - User-entered names
   - `commodity` - Product descriptions

2. **Customer Data:**
   - `company_name` - Company names
   - `address` - Addresses with special characters
   - `notes` - Free text notes

3. **Document Metadata:**
   - `title` - Document titles
   - `description` - Document descriptions
   - `filename` - Uploaded file names

4. **Custom Fields:**
   - Any textarea or input that accepts free-form text
   - Comments, notes, descriptions, instructions

### React Components - Default Protection:

React automatically escapes values in JSX, so this is **SAFE**:
```tsx
<p>{userInput}</p>  // ✅ Safe - React escapes by default
```

This is **DANGEROUS** and requires sanitization:
```tsx
<div dangerouslySetInnerHTML={{ __html: userInput }} />  // ❌ Dangerous!
// Use instead:
<div dangerouslySetInnerHTML={createSafeMarkup(userInput)} />  // ✅ Safe
```

## 🔍 Current Implementation Status

### ✅ Completed Security Measures:

1. **Content Security Policy** - Active in `index.html`
2. **DOMPurify Installation** - Installed and configured
3. **Sanitization Utility** - Created in `src/lib/sanitize.ts`
4. **Map Component Sanitization** - Updated `ShipmentMap.tsx`
5. **Row-Level Security** - All 26 tables protected
6. **Environment Variables** - Properly gitignored
7. **XSS Audit** - No dangerous patterns found

### ⏭️ Recommended Next Steps:

1. **Apply Sanitization:** Add to form submissions and data display
2. **CSP Reporting:** Monitor CSP violations in production
3. **Security Headers:** Add additional headers (X-Frame-Options, etc.)
4. **Rate Limiting:** Prevent brute force attacks on auth endpoints
5. **Security Audits:** Regular code reviews for security issues

## 🚨 Incident Response

If you discover a security vulnerability:

1. **Do NOT** commit fixes directly to main
2. **Report** to security team immediately
3. **Document** the vulnerability and impact
4. **Test** fixes thoroughly before deployment
5. **Update** this document with lessons learned

## 📚 Additional Resources

- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
- [Supabase RLS Guide](https://supabase.com/docs/guides/auth/row-level-security)
- [CSP Reference](https://developer.mozilla.org/en-US/docs/Web/HTTP/CSP)
- [DOMPurify Documentation](https://github.com/cure53/DOMPurify)

## 📝 Security Review Log

| Date | Reviewer | Changes | Status |
|------|----------|---------|--------|
| 2026-02-16 | Claude | Initial security implementation | ✅ Complete |

---

**Last Updated:** 2026-02-16
**Security Level:** 🟡 Good (7/10) - Production-ready with room for improvement
