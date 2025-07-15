# Reseller Login System - Complete Guide

## System Overview

```
GLINTA AFRICA SYSTEM
├── YOUR ADMIN LOGIN (admin.php) - You see everything
│   ├── Your Direct Customers (PPPoE + Hotspot)
│   ├── Reseller Management
│   └── All Revenue Reports
│
└── RESELLER LOGIN (reseller.php) - Separate login for resellers
    ├── Their Own Customers Only
    ├── Their Own Revenue Only
    └── Their Subscription Status
```

## How Resellers Will Login

### 1. Separate Login URL
- **Your Admin**: `https://yourdomain.com/admin/`
- **Reseller Login**: `https://yourdomain.com/reseller/`

### 2. Reseller Registration Process
1. You create reseller account in your admin panel
2. Reseller gets email with login credentials
3. Reseller logs into separate reseller portal
4. Reseller manages only their own customers

### 3. What Resellers See vs What You See

#### RESELLER DASHBOARD:
```
┌─────────────────────────────────────────────┐
│           RESELLER DASHBOARD                │
├─────────────────────────────────────────────┤
│ MY SUBSCRIPTION                             │
│ • Status: Active                            │
│ • Expires: 2024-02-15                      │
│ • Plan: Professional (200 customers)        │
│ • Days Left: 25                            │
│                                             │
│ MY CUSTOMERS REVENUE (Today)                │
│ • PPPoE Payments: KSh 15,000               │
│ • Hotspot Payments: KSh 8,500              │
│ • Total: KSh 23,500                        │
│                                             │
│ MY MIKROTIK STATUS                          │
│ • Router IP: 192.168.1.1                   │
│ • Active PPPoE: 45                          │
│ • Active Hotspot: 23                       │
│                                             │
│ MY CUSTOMERS (200 max)                      │
│ • Active: 68                                │
│ • Expired: 12                               │
│ • Add New Customer [Button]                 │
└─────────────────────────────────────────────┘
```

#### YOUR SUPER ADMIN DASHBOARD:
```
┌─────────────────────────────────────────────┐
│          SUPER ADMIN DASHBOARD              │
├─────────────────────────────────────────────┤
│ MY DIRECT CUSTOMERS REVENUE                 │
│ • PPPoE Payments: KSh 5,000 ← Your direct  │
│ • Hotspot Payments: KSh 20 ← Your KSh 20   │
│                                             │
│ RESELLER SUBSCRIPTIONS                      │
│ • Active Resellers: 15                      │
│ • Monthly Subscription Revenue: KSh 150,000 │
│ • Expiring This Week: 3                     │
│                                             │
│ ALL SYSTEM TOTALS                           │
│ • Total Customer Payments: KSh 500,000     │
│ • My Direct Revenue: KSh 25,000            │
│ • Reseller Subscription Revenue: KSh 150,000│
│                                             │
│ RESELLER MANAGEMENT                         │
│ • View All Resellers [Button]               │
│ • Add New Reseller [Button]                 │
│ • Subscription Reports [Button]             │
└─────────────────────────────────────────────┘
```

## Automatic Payment Visibility

### For Resellers:
1. **Their Customer Pays** → Shows immediately on reseller dashboard
2. **Payment Filters**: Only see transactions with their reseller_id
3. **Real-time Updates**: M-Pesa callbacks update their revenue instantly

### For You (Super Admin):
1. **Your Direct Customer Pays** → Shows on your dashboard (like KSh 20)
2. **Reseller Subscription Pays** → Shows as subscription revenue
3. **All Payments Summary**: See totals but not individual reseller customer details

## Database Separation Logic

```sql
-- Your direct customers (reseller_id = 1)
SELECT * FROM tbl_transactions WHERE reseller_id = 1

-- Reseller X customers (reseller_id = X)  
SELECT * FROM tbl_transactions WHERE reseller_id = X

-- Reseller subscription payments (separate table)
SELECT * FROM tbl_reseller_subscription_payments WHERE reseller_id = X
```

## Reseller Auto-Logout System

### Subscription Check on Every Login:
1. **Active**: Full access to system
2. **Expiring (7 days)**: Warning banner shown
3. **Grace Period (3 days)**: Red warning, limited access
4. **Expired**: Automatic logout, redirect to payment page

### Grace Period Logic:
```
Subscription Expires → 3 Days Grace → Auto Suspension
     ↓                      ↓              ↓
  Warning Banner      Red Alert      Login Blocked
```

## Implementation Steps

### Step 1: Fix Your Current Issues
```bash
# Fix your KSh 20 payment sync
php fix_payment_sync_simple.php

# Install reseller system
php install_reseller_simple.php
```

### Step 2: Create Reseller Login Portal
- Separate login page for resellers
- Different dashboard with filtered data
- Subscription status checking

### Step 3: Set Up Automatic Processes
- M-Pesa callback updates correct reseller_id
- Daily subscription status checks
- Automatic revenue calculations

### Step 4: Test Complete Flow
1. Create test reseller account
2. Add test customers under reseller
3. Process test payments
4. Verify separation works

## Menu Structure

### YOUR ADMIN MENU:
- Dashboard (all data)
- My Customers 
- My Routers
- **Resellers** → Manage resellers
- **Subscription Payments** → Track reseller payments
- Reports (everything)
- Settings

### RESELLER MENU:
- Dashboard (filtered)
- My Customers (their customers only)
- My Routers (their routers only) 
- **My Subscription** → View status, renew
- Reports (their data only)
- Settings (limited)

## Security & Isolation

1. **Database Filtering**: Every query includes reseller_id filter
2. **Session Management**: Separate session handling for resellers
3. **Menu Hiding**: Resellers can't see super admin features
4. **Data Protection**: Resellers never see other reseller data
5. **Automatic Logout**: Expired subscriptions = no access

This system ensures complete separation while giving you full oversight of the entire operation.