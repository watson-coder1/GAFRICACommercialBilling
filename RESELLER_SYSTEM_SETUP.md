# Glinta Africa Reseller System Setup Guide

## System Overview

The Glinta Africa Reseller System allows partners to manage their own hotspot and PPOE customers with comprehensive billing, MikroTik integration, and automated subscription management.

## 🔧 Installation Steps

### 1. Install Payment Tracking Widget

Run this to add payment tracking to superadmin dashboard:

```bash
cd /opt/glinta-hotspot/app
php install_payment_tracking_widget.php
```

### 2. Setup Reseller Auto-Invoice System

```bash
cd /opt/glinta-hotspot/app
php setup_reseller_cron.php
```

This creates automated monthly billing for resellers based on 0.5% of their transaction volume.

### 3. Test MikroTik Integration

Test multiple router support:

```bash
php multi_router_manager.php?test=1&reseller_id=2
```

## 🔑 Login Information

### Test Reseller Account

**URL:** `https://glintaafrica.com/reseller.php`

**Credentials:**
- Username: `testreseller`
- Password: `test123`
- Email: `test@reseller.com`

### Superadmin Dashboard

**URL:** `https://glintaafrica.com/admin.php`

**Features:**
- Payment tracking widget showing all revenue streams
- Reseller management
- System monitoring
- Automated billing oversight

## 📊 Reseller Dashboard Features

### 1. Dashboard Overview
- Revenue statistics (today/week/month)
- Customer count and status
- MikroTik router status
- Subscription information
- Payment history

### 2. Customer Management
- Add/edit/delete customers
- Customer recharging system
- Voucher redemption
- Customer plan management
- Disconnect/reconnect customers

### 3. MikroTik Router Management
- Add multiple routers
- Test router connectivity
- Load balancing across routers
- Real-time user monitoring
- Automated user provisioning

### 4. Reports & Analytics
- Revenue reports by period
- Customer analytics
- Transaction history
- Router performance metrics

### 5. Subscription Management
- Automatic subscription monitoring
- STK push payment integration
- Invoice generation
- Payment history

## 🖥️ MikroTik Configuration

### Router Setup Requirements

1. **API Access:** Enable API on port 8728 (or custom port)
2. **User Profile:** Create appropriate user profiles for plans
3. **Hotspot Setup:** Configure hotspot server (if using hotspot)
4. **PPOE Setup:** Configure PPOE server (if using PPOE)

### Adding Routers to Reseller

1. Go to **MikroTik** section in reseller dashboard
2. Click **Add Router**
3. Fill in router details:
   - **Name:** Friendly name for the router
   - **IP Address:** Router's IP address
   - **Username:** API username
   - **Password:** API password
   - **API Port:** Default 8728
   - **SSL:** Enable if using SSL
4. Test connection before saving

### Multiple Router Support

The system automatically:
- Load balances new customers across routers
- Syncs user data across all routers
- Handles failover scenarios
- Monitors router health

## 💳 Payment Integration

### M-Pesa Integration

**Automatic Features:**
- STK push for customer payments
- Monthly reseller invoices
- Subscription renewals
- Payment confirmations

**Configuration:**
- Callback URLs are pre-configured
- Commission rate: 0.5% of monthly revenue
- Minimum payment: KSh 100

### Billing Cycle

1. **Monthly Calculation:** System calculates 0.5% of monthly revenue
2. **Auto-Invoice:** Sends invoice 3 days before expiry
3. **STK Push:** Automatically sends payment request
4. **Grace Period:** 3 days grace period for expired accounts
5. **Suspension:** Automatic logout after grace period

## 🔐 Security Features

### Authentication
- Secure login system
- Session management
- Automatic logout for expired accounts
- Password hashing

### Access Control
- Reseller-specific data isolation
- Role-based permissions
- Audit logging
- Secure API integration

## 📱 Customer Experience

### Removed Member Panel
The old member panel has been integrated into the reseller dashboard for better control:

- **Unified Management:** All customer operations in one place
- **Better Support:** Resellers can directly help customers
- **Improved Security:** Centralized authentication
- **Enhanced Features:** More payment options and plan management

## 🚀 Getting Started

### For Resellers

1. **Login** to reseller dashboard
2. **Add MikroTik Routers** in the MikroTik section
3. **Test Connectivity** to ensure proper setup
4. **Add Customers** in the Customer section
5. **Configure Plans** and assign to customers
6. **Monitor Revenue** in the Reports section

### For Superadmin

1. **Access Admin Dashboard** to view payment tracking
2. **Monitor Reseller Activity** in the reseller section
3. **Review System Logs** for audit trail
4. **Manage Subscription Billing** and invoices

## 🔍 Troubleshooting

### Common Issues

1. **500 Error on Reseller Login**
   - Check file permissions
   - Verify database connectivity
   - Review error logs

2. **MikroTik Connection Failed**
   - Verify API is enabled
   - Check IP address and credentials
   - Test network connectivity

3. **Payment Issues**
   - Verify M-Pesa configuration
   - Check callback URLs
   - Review payment logs

### Log Files

- **System Logs:** `/var/log/glinta-hotspot/`
- **Payment Logs:** `/var/log/reseller_invoices.log`
- **Error Logs:** Check Apache/PHP error logs

## 📈 System Monitoring

### Key Metrics to Monitor

1. **Revenue Trends:** Daily/weekly/monthly revenue
2. **Customer Growth:** New customer acquisition
3. **Router Performance:** Active users per router
4. **Payment Success Rate:** STK push success rate
5. **Subscription Health:** Active vs expired resellers

### Automated Alerts

- Low revenue warnings
- Router connectivity issues
- Failed payment notifications
- Subscription expiry alerts

## 🛠️ Advanced Configuration

### Custom Pricing
- Configure commission rates per reseller
- Set minimum payment thresholds
- Create custom billing cycles

### White-Label Options
- Custom branding for resellers
- Logo and color customization
- Custom domain support

### API Integration
- REST API for third-party integrations
- Webhook support for real-time updates
- Custom reporting endpoints

## 📞 Support

For technical support and system administration:
- Monitor the payment tracking widget
- Review system logs regularly
- Test MikroTik connectivity
- Verify payment callback functionality

---

**System Status:** ✅ All components installed and configured
**Last Updated:** $(date)
**Version:** 2.0.0