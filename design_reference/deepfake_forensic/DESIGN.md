---
name: Deepfake Forensic
colors:
  surface: '#FFFFFF'
  surface-dim: '#cbdbf5'
  surface-bright: '#f8f9ff'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#eff4ff'
  surface-container: '#e5eeff'
  surface-container-high: '#dce9ff'
  surface-container-highest: '#d3e4fe'
  on-surface: '#0b1c30'
  on-surface-variant: '#45464d'
  inverse-surface: '#213145'
  inverse-on-surface: '#eaf1ff'
  outline: '#76777d'
  outline-variant: '#c6c6cd'
  surface-tint: '#565e74'
  primary: '#000000'
  on-primary: '#ffffff'
  primary-container: '#131b2e'
  on-primary-container: '#7c839b'
  inverse-primary: '#bec6e0'
  secondary: '#006a63'
  on-secondary: '#ffffff'
  secondary-container: '#99efe5'
  on-secondary-container: '#006f67'
  tertiary: '#000000'
  on-tertiary: '#ffffff'
  tertiary-container: '#271901'
  on-tertiary-container: '#98805d'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#dae2fd'
  primary-fixed-dim: '#bec6e0'
  on-primary-fixed: '#131b2e'
  on-primary-fixed-variant: '#3f465c'
  secondary-fixed: '#9cf2e8'
  secondary-fixed-dim: '#80d5cb'
  on-secondary-fixed: '#00201d'
  on-secondary-fixed-variant: '#00504a'
  tertiary-fixed: '#fcdeb5'
  tertiary-fixed-dim: '#dec29a'
  on-tertiary-fixed: '#271901'
  on-tertiary-fixed-variant: '#574425'
  background: '#F8FAFC'
  on-background: '#0b1c30'
  surface-variant: '#d3e4fe'
  alert-fake: '#EF4444'
  safe-real: '#10B981'
  muted-text: '#64748B'
  slate-text: '#334155'
typography:
  headline-lg:
    fontFamily: Inter
    fontSize: 22px
    fontWeight: '700'
    lineHeight: 28px
    letterSpacing: -0.02em
  headline-md:
    fontFamily: Inter
    fontSize: 18px
    fontWeight: '600'
    lineHeight: 24px
  headline-sm:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '600'
    lineHeight: 22px
  body-lg:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 20px
  body-md:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '400'
    lineHeight: 18px
  label-lg:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '600'
    lineHeight: 16px
    letterSpacing: 0.01em
  label-md:
    fontFamily: Inter
    fontSize: 10px
    fontWeight: '500'
    lineHeight: 14px
  caption:
    fontFamily: Inter
    fontSize: 10px
    fontWeight: '400'
    lineHeight: 14px
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  container-margin: 20px
  stack-gap-lg: 40px
  stack-gap-md: 24px
  stack-gap-sm: 16px
  inline-gap: 12px
  grid-gutter: 16px
---

## Brand & Style

The design system is engineered for a high-stakes cybersecurity environment, specifically focused on deepfake detection and digital forensics. It targets a demographic of security professionals, academic researchers, and tech-savvy users who require an interface that feels authoritative, clinical, and technologically advanced.

The aesthetic follows a **Corporate / Modern** style with a distinct **Technical** edge. It prioritizes clarity and focus to reduce cognitive load during critical analysis. The visual language conveys stability through a weighted dark palette, precision through sharp geometry, and trustworthiness through a clean, systematic layout.

Key brand attributes:
- **Clinical Precision:** High contrast and structured grids suggest scientific accuracy.
- **Vigilance:** Intentional use of "Alert Red" and "Safe Green" provides immediate, unmistakable status communication.
- **Advanced Technology:** Subtle use of depth and technical data visualization reinforces the presence of the "Antigravity" AI agent.

## Colors

The color system is rooted in **Dark Slate (#0F172A)** to ground the interface in professionalism and authority. **Deep Teal (#0F766E)** is utilized as the primary action color, bridging the gap between traditional corporate blue and high-tech forensic emerald.

### Functional Implementation
- **Primary (Dark Slate):** Used for headers, critical titles, and the highest-priority action buttons to convey maximum weight.
- **Secondary (Deep Teal):** Used for interactive elements, focus states, and branding accents.
- **Semantic Accents:** A strict binary system is used for forensic results: **Alert Red (#EF4444)** for FAKE/Manipulated findings and **Safe Green (#10B981)** for REAL/Verified findings.
- **Surface Strategy:** The app uses a "Light" mode default with **#F8FAFC** as the base canvas, allowing white cards (#FFFFFF) with subtle shadows to create a clear hierarchical stack.

## Typography

This design system utilizes **Inter** for all typographic roles. Its neutral, grotesque style and high legibility at small sizes make it ideal for data-heavy forensic reports.

The scale is intentionally compact to maximize information density on mobile screens:
- **Headlines:** Use Bold and Semi-Bold weights in Dark Slate (#0F172A) to establish clear section boundaries.
- **Body Text:** Set in Slate Text (#334155) for optimal reading comfort against white surfaces.
- **Labels & Metadata:** Use smaller sizes (10pt-12pt) with increased letter spacing for technical logs and descriptive captions to differentiate them from functional UI text.

## Layout & Spacing

The layout follows a structured **Fixed Grid** approach for mobile, utilizing a standard 20px horizontal margin to ensure content is safely inset. 

### Spacing Principles
- **Vertical Rhythm:** A consistent 8px-based stepping system. Use 40px for major section breaks (e.g., Logo to Form), 24px for standard component grouping, and 16px for internal card spacing.
- **Dashboard Grid:** Analytics overview uses a 2x2 grid with 16px gutters to balance density and touch-target accessibility.
- **Mobile Reflow:** For small devices (under 360px width), the 2x2 grid should reflow into a single column stack to maintain legibility of forensic values.

## Elevation & Depth

Visual hierarchy is achieved through a combination of **Tonal Layering** and **Ambient Shadows**.

- **Base Layer:** Background (#F8FAFC) is the lowest level.
- **Content Layer:** Cards and Input Fields use Surface White (#FFFFFF) to pop against the background.
- **Shadow Profile:** A very subtle, diffused shadow `(0, 4, 8, rgba(0,0,0,0.04))` is applied to cards to provide depth without cluttering the interface.
- **Hero Elevation:** High-contrast backgrounds (Dark Slate) are used for "Hero Action Cards" to pull the most important user task to the foreground immediately.
- **Forensic Overlay:** AI Agent chat utilizes a sliding bottom sheet metaphor, using a slightly higher elevation index to suggest it is an "assistant" layer sitting above the raw data.

## Shapes

The shape language balances modern approachability with technical precision.
- **Cards:** Use a **12px radius** for a contemporary, professional feel that softens the high-contrast data.
- **Interactive Elements:** Buttons and Input Fields use an **8px radius**. This "tighter" cornering suggests precision, firmness, and a systematic nature.
- **Forensic Badges:** Status indicators (REAL/FAKE) should use a subtle 4px radius or be fully rectangular to emphasize their "official" label status.

## Components

### Buttons
- **Primary:** Full-width, Dark Slate background, white bold text, 8px radius. Used for the ultimate action (e.g., "JALANKAN ANALISIS").
- **Secondary:** Deep Teal background or outline, white or teal text. Used for supporting actions like "Login" or "Ambil Kamera."
- **Status Buttons:** Emerald Green (#10B981) for positive "Start" actions in the dashboard.

### Cards
- **Analytics Cards:** White surface, 12px radius, light shadow. Must include a clear icon, a bold primary metric, and a muted secondary label.
- **Hero Card:** Dark Slate background, 12px radius. High contrast white text with a bright accent button.

### Input Fields
- **Standard Input:** 8px radius, white surface, subtle 1px border (#E2E8F0). Prefix icons are mandatory to improve scanability (e.g., Mail for email, Lock for password).

### Forensic Specifics
- **Verdict Badge:** High-impact full-bleed banners in Red (#EF4444) or Green (#10B981).
- **Confidence Bar:** A linear progress indicator that matches the color of the verdict, providing a visual representation of the model's certainty.
- **AI Chat Bubbles:** Rounded corners (12px) with an asymmetrical bottom corner on the sender's side. Agent bubbles use a very light gray (#F1F5F9) to distinguish from the primary UI surfaces.