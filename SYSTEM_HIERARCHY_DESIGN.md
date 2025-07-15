# Glinta Africa Billing System - Hierarchy Design

## System Architecture Overview

### 1. User Levels

```
┌─────────────────────────────────────────────────────────┐
│                    SUPER ADMIN                          │
│                  (Glinta Africa)                        │
│  • Manages entire system                                │
│  • Sees all resellers & their revenue                   │
│  • Manages own direct customers                         │
│  • Has own MikroTik devices                            │
└────────────────────┬───────────────────────────────────┘
                     │
        ┌────────────┴────────────┬─────────────────────┐
        │                         │                     │
┌───────▼────────┐       ┌───────▼────────┐   ┌───────▼────────┐
│  STAFF ADMIN   │       │   RESELLER 1   │   │   RESELLER 2   │
│ (Your Employee)│       │ (Pays Monthly) │   │ (Pays Monthly) │
│ • Manage all   │       │ • Own dashboard │   │ • Own dashboard │
│ • View reports │       │ • Own MikroTik  │   │ • Own MikroTik  │
└────────────────┘       │ • Own customers │   │ • Own customers │
                         └────────┬────────┘   └────────┬────────┘
                                  │                      │
                         ┌────────▼────────┐   ┌────────▼────────┐
                         │   CUSTOMERS     │   │   CUSTOMERS     │
                         │ (Use Reseller's │   │ (Use Reseller's │
                         │    MikroTik)    │   │    MikroTik)    │
                         └─────────────────┘   └─────────────────┘
```

### 2. Payment Types

#### A. Customer Payments (Hotspot/PPPoE)
- **Your Direct Customers**: Pay for internet packages (like the KSh 20)
- **Reseller's Customers**: Pay to their reseller for internet
- These show in "Income/Revenue" widgets

#### B. Reseller Subscription Payments
- **Monthly/Yearly subscriptions** to use your billing system
- Different from customer payments
- Need separate tracking and auto-logout mechanism

### 3. Dashboard Separation

#### Super Admin Dashboard
```
┌─────────────────────────────────────────────┐
│            SUPER ADMIN DASHBOARD            │
├─────────────────────────────────────────────┤
│ MY REVENUE                                  │
│ • Direct Customer Payments: KSh XXX         │
│ • Today/Week/Month totals                   │
│                                             │
│ RESELLER SUBSCRIPTIONS                      │
│ • Active Resellers: 10                      │
│ • Monthly Subscription Revenue: KSh YYY     │
│ • Expiring Soon: 3                          │
│                                             │
│ MY MIKROTIK STATS                           │
│ • Active PPPoE: XX                          │
│ • Active Hotspot: XX                        │
│                                             │
│ SYSTEM OVERVIEW                             │
│ • Total Customers (All): XXX                │
│ • Total Revenue (All): KSh ZZZ              │
└─────────────────────────────────────────────┘
```

#### Reseller Dashboard
```
┌─────────────────────────────────────────────┐
│            RESELLER DASHBOARD               │
├─────────────────────────────────────────────┤
│ MY SUBSCRIPTION                             │
│ • Status: Active                            │
│ • Expires: 2024-01-15                      │
│ • Plan: Premium (100 customers)             │
│                                             │
│ MY REVENUE                                  │
│ • Customer Payments: KSh XXX                │
│ • Today/Week/Month                          │
│                                             │
│ MY MIKROTIK STATS                           │
│ • Active PPPoE: XX                          │
│ • Active Hotspot: XX                        │
└─────────────────────────────────────────────┘
```

### 4. Implementation Strategy

#### Phase 1: Fix Current Payment Issue
1. Run payment sync for your KSh 20
2. Ensure all M-Pesa payments show on dashboard

#### Phase 2: Reseller Subscription System
1. Create `tbl_reseller_subscriptions` tracking
2. Add subscription payment gateway
3. Implement auto-logout on expiry

#### Phase 3: Dashboard Separation
1. Modify existing widgets to filter by reseller_id
2. Create super admin specific widgets
3. Add reseller subscription revenue widget

#### Phase 4: Access Control
1. Check reseller subscription status on login
2. Redirect expired resellers to payment page
3. Implement role-based menu visibility

### 5. Database Design for Clarity

```sql
-- Customer payments (existing)
tbl_transactions (
    id, username, price, reseller_id, type
    -- reseller_id = 1 for your direct customers
    -- reseller_id = X for reseller's customers
)

-- Reseller subscription payments (new)
tbl_reseller_subscription_payments (
    id, reseller_id, amount, payment_date, 
    payment_method, reference, status
)

-- Track subscription status
tbl_reseller_subscriptions (
    id, reseller_id, plan_id, start_date, 
    end_date, status, auto_renew
)
```

### 6. Recommended Menu Structure

#### Super Admin Menu
- Dashboard (with all metrics)
- My Customers
- My Routers
- Reseller Management
  - View Resellers
  - Subscription Payments
  - Reseller Plans
- Reports
  - My Revenue
  - Reseller Revenue
  - System Overview
- Settings

#### Reseller Menu
- Dashboard (filtered data)
- My Customers
- My Routers
- My Subscription
- Reports (own data only)
- Settings (limited)

### 7. Key Implementation Rules

1. **Data Isolation**: Always filter by reseller_id
2. **Subscription Check**: Verify active subscription on every login
3. **Clear Separation**: Different payment tables for services vs subscriptions
4. **Audit Trail**: Log all reseller activities
5. **Graceful Expiry**: Give 3-day grace period before blocking access