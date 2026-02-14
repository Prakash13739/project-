# 🚀 E-Commerce Application - Complete Setup Guide

## 📋 Prerequisites

### MySQL Installation Required

**MySQL is not currently detected on your system.** You'll need to install it first.

### Option 1: Install MySQL Server (Recommended)

1. **Download MySQL Community Server**
   - Visit: https://dev.mysql.com/downloads/mysql/
   - Choose: Windows (x86, 64-bit), MSI Installer
   - Download: `mysql-installer-community-8.0.XX.msi`

2. **Install MySQL**
   ```
   - Run the installer
   - Choose "Developer Default" or "Custom"
   - Set root password: root (or update application.properties)
   - Keep default port: 3306
   - Complete the installation
   ```

3. **Add MySQL to PATH**
   ```
   Add to System Environment Variables:
   C:\Program Files\MySQL\MySQL Server 8.0\bin
   ```

4. **Verify Installation**
   ```bash
   mysql --version
   ```

### Option 2: Use XAMPP (Alternative)

1. Download XAMPP from: https://www.apachefriends.org/
2. Install and start MySQL from XAMPP Control Panel
3. Default credentials: `root` / (no password)
4. Update `application.properties` if needed

---

## 🗄️ Database Setup

### Automatic Setup (Recommended)

The application will **automatically create all tables** when you first run it!

Just make sure MySQL is running, then execute:
```bash
d:\project\run.bat
```

Thanks to: `spring.jpa.hibernate.ddl-auto=update`

### Manual Setup (Optional)

If you want to pre-populate with sample products:

1. **Open MySQL Command Line or MySQL Workbench**

2. **Execute the setup script:**
   ```bash
   mysql -u root -p < d:\project\setup_mysql.sql
   ```
   Enter password: `root`

This will:
- Create `ecommerce_db` database
- Create all tables (users, products, cart, orders)
- Insert 20 sample products (Amazon-like items)

---

## ⚙️ Configuration

Your application is pre-configured with:

### Database Settings (`application.properties`)
```properties
spring.datasource.url=jdbc:mysql://localhost:3306/ecommerce_db?createDatabaseIfNotExist=true
spring.datasource.username=root
spring.datasource.password=root
spring.jpa.hibernate.ddl-auto=update
```

### If Your MySQL Password is Different:
Edit `d:\project\src\main\resources\application.properties`:
```properties
spring.datasource.password=YOUR_PASSWORD
```

---

## 🏃 Running the Application

### Start the Application

```bash
cd d:\project
run.bat
```

The application will:
1. ✅ Build with Maven
2. ✅ Connect to MySQL
3. ✅ Create database and tables automatically
4. ✅ Start on http://localhost:8080

### Access the Application

- **Homepage**: http://localhost:8080
- **Login**: http://localhost:8080/login
- **Register**: http://localhost:8080/register
- **Admin Panel**: Login with admin credentials (created automatically)

---

## 👤 Default Admin Account

The application automatically creates an admin user on first startup:

```
Username: admin
Password: admin
Role: ROLE_ADMIN
```

**Admin Features:**
- Add new products: http://localhost:8080/product/add
- Delete products: Delete button on product cards
- View all orders

---

## 🛒 Features Implemented

### Customer Features
- ✅ User Registration & Login
- ✅ Browse Products by Category
- ✅ Product Search
- ✅ Add to Cart
- ✅ Update Quantity
- ✅ Remove from Cart
- ✅ Checkout (Address + Payment)
- ✅ Order Placement
- ✅ Order Confirmation

### Admin Features
- ✅ Add New Products
- ✅ Delete Products
- ✅ View Orders

### Security
- ✅ Spring Security with BCrypt (strength 12)
- ✅ Role-based Access (ADMIN/USER)
- ✅ AES-256 Encryption for sensitive order data
- ✅ Encrypted shipping address
- ✅ Encrypted payment information

### UI/UX
- ✅ Premium Glassmorphism Design
- ✅ Bootstrap 5 Framework
- ✅ Responsive (Mobile + Desktop)
- ✅ Smooth Animations
- ✅ Modern Gradient Theme
- ✅ Glossy Cards & Buttons

---

## 📦 Sample Products Included

The `setup_mysql.sql` script includes 20 Amazon-like products:

**Categories:**
- 📱 Electronics (iPhones, Samsung phones, Headphones)
- 💻 Computers (MacBook Pro, Dell XPS)
- 📱 Tablets (iPad Air, Galaxy Tab)
- 👟 Shoes (Nike, Adidas)
- 📷 Cameras (Canon, Sony)
- ⌚ Wearables (Apple Watch, Fitbit)
- 🎮 Gaming (PS5, Xbox)
- 🔊 Audio (Bose, JBL)
- 🏠 Smart Home (Echo, Ring)
- 📚 Books (Kindle)

---

## 🔧 Troubleshooting

### MySQL Connection Error

**Error:** `Communications link failure`

**Solution:**
1. Verify MySQL is running:
   ```bash
   # Windows Services
   services.msc
   # Look for "MySQL80" service
   ```

2. Check MySQL port 3306 is not blocked

3. Verify credentials in `application.properties`

### Database Not Created

**Solution:**
The application auto-creates the database thanks to:
```
?createDatabaseIfNotExist=true
```

If it fails, manually create it:
```sql
CREATE DATABASE ecommerce_db;
```

### Build Errors

**Solution:**
1. Clean and rebuild:
   ```bash
   mvn clean package -DskipTests
   ```

2. Check Maven is working:
   ```bash
   mvn --version
   ```

---

## 📊 Database Schema

### Tables Created Automatically

1. **users** - User accounts (customers + admin)
2. **products** - Product catalog
3. **cart** - Shopping carts
4. **cart_items** - Items in each cart
5. **orders** - Placed orders with encrypted data

All tables include proper:
- Primary keys
- Foreign key relationships
- Indexes for performance
- UTF-8 character encoding

---

## 🎨 UI Customization

The UI uses a premium glassmorphism theme with:

- **Font**: Google Font 'Outfit'
- **Colors**: Dark blue → Purple gradient
- **Effects**: Glass blur, smooth shadows
- **Animations**: 0.3s ease transitions

To customize, edit:
```
d:\project\src\main\resources\static\css\style.css
```

---

## 📞 Support

If you encounter any issues:

1. Check MySQL is installed and running
2. Verify `application.properties` credentials
3. Review build logs in the terminal
4. Check port 8080 is available

---

## ✅ Quick Start Checklist

- [ ] Install MySQL Server
- [ ] Start MySQL service
- [ ] Update password in `application.properties` (if needed)
- [ ] Run `setup_mysql.sql` (optional, for sample data)
- [ ] Execute `run.bat`
- [ ] Visit http://localhost:8080
- [ ] Create account or login as admin
- [ ] Start shopping! 🛒

---

**Enjoy your premium e-commerce application!** 🎉
