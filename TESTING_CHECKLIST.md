# ✅ Testing Checklist - Catatin App

## 📋 Pre-Test Setup

### 1. Environment Check
- [ ] Flutter SDK installed (run: `flutter --version`)
- [ ] Dependencies installed (run: `flutter pub get`)
- [ ] No compile errors (run: `flutter analyze`)
- [ ] Device/Emulator ready (run: `flutter devices`)

### 2. First Run
```bash
# Terminal commands:
flutter pub get
flutter run

# Setelah app muncul, tekan 'R' (capital R) untuk full restart
# Check console untuk log: ✅ FFI Database initialized
```

---

## 🧪 Functional Testing

### Test Group 1: Authentication

#### ✅ Test 1.1: Login dengan Default User
**Steps:**
1. App start → Splash screen (2 detik)
2. Navigate to Login page
3. Input:
   - Username: `admin`
   - Password: `password123`
4. Click "Masuk"

**Expected:**
- [ ] No error message
- [ ] Navigate to Dashboard
- [ ] Dashboard shows empty state (no notes yet)
- [ ] Console log: "Login successful: admin"

**Actual Result:** ________________

---

#### ✅ Test 1.2: Login dengan Wrong Credentials
**Steps:**
1. Logout dari dashboard
2. Input:
   - Username: `wronguser`
   - Password: `wrongpass`
3. Click "Masuk"

**Expected:**
- [ ] Error message appears
- [ ] TextField border turns red
- [ ] SnackBar shows: "Login gagal..."
- [ ] Stay on login page

**Actual Result:** ________________

---

#### ✅ Test 1.3: Register New User
**Steps:**
1. From login page, click "Daftar"
2. Fill form:
   - Nama Lengkap: `Test User`
   - Username: `testuser`
   - Password: `test123`
3. Click "Daftar"

**Expected:**
- [ ] Success SnackBar: "Registrasi berhasil!"
- [ ] Auto-login and navigate to Dashboard
- [ ] Console log: "Register successful: testuser"
- [ ] Dashboard shows empty state

**Actual Result:** ________________

---

#### ✅ Test 1.4: Register dengan Duplicate Username
**Steps:**
1. Logout
2. Click "Daftar"
3. Try register with username: `admin` (already exists)

**Expected:**
- [ ] Error SnackBar: "Registrasi gagal: Username sudah digunakan"
- [ ] Stay on register page

**Actual Result:** ________________

---

### Test Group 2: CRUD Catatan

#### ✅ Test 2.1: Create Note - Kuliah
**Steps:**
1. Login as any user
2. Click FAB (+) button
3. Fill form:
   - Judul: `Materi UKPL`
   - Kategori: `Kuliah`
   - Isi: `Belajar MVC Pattern dengan Flutter`
4. Click "Simpan Catatan"

**Expected:**
- [ ] Success SnackBar
- [ ] Navigate back to Dashboard
- [ ] Note appears in list with green "Kuliah" badge
- [ ] Shows timestamp

**Actual Result:** ________________

---

#### ✅ Test 2.2: Create Note - Kerja
**Steps:**
1. Click FAB (+)
2. Fill form:
   - Judul: `Meeting Client`
   - Kategori: `Kerja`
   - Isi: `Diskusi requirement project`
3. Click "Simpan Catatan"

**Expected:**
- [ ] Note appears with orange "Kerja" badge

**Actual Result:** ________________

---

#### ✅ Test 2.3: Create Note - Pribadi
**Steps:**
1. Click FAB (+)
2. Fill form:
   - Judul: `Daftar Belanja`
   - Kategori: `Pribadi`
   - Isi: `Beras, Minyak, Gula`
3. Click "Simpan Catatan"

**Expected:**
- [ ] Note appears with purple "Pribadi" badge

**Actual Result:** ________________

---

#### ✅ Test 2.4: Read Notes - List View
**Steps:**
1. View Dashboard with 3 notes created

**Expected:**
- [ ] All 3 notes visible
- [ ] Each note shows: title, content preview, category badge, date
- [ ] Notes ordered by Latest (newest first)

**Actual Result:** ________________

---

#### ✅ Test 2.5: Filter by Category - Kuliah
**Steps:**
1. From Dashboard
2. Tap "Kuliah" chip

**Expected:**
- [ ] Only "Kuliah" notes shown (green badge)
- [ ] Other notes hidden
- [ ] Chip "Kuliah" appears selected/highlighted

**Actual Result:** ________________

---

#### ✅ Test 2.6: Filter by Category - Semua
**Steps:**
1. Tap "Semua" chip

**Expected:**
- [ ] All notes shown again
- [ ] All 3 notes visible

**Actual Result:** ________________

---

#### ✅ Test 2.7: Sort by A-Z
**Steps:**
1. Click sort icon in AppBar
2. Select "A-Z"

**Expected:**
- [ ] Notes re-ordered alphabetically
- [ ] "Daftar Belanja" → "Materi UKPL" → "Meeting Client"

**Actual Result:** ________________

---

#### ✅ Test 2.8: Sort by Z-A
**Steps:**
1. Click sort icon
2. Select "Z-A"

**Expected:**
- [ ] Notes in reverse order
- [ ] "Meeting Client" → "Materi UKPL" → "Daftar Belanja"

**Actual Result:** ________________

---

#### ✅ Test 2.9: Sort by Latest
**Steps:**
1. Click sort icon
2. Select "Latest"

**Expected:**
- [ ] Notes ordered by creation date (newest first)

**Actual Result:** ________________

---

#### ✅ Test 2.10: Update Note
**Steps:**
1. Tap on "Materi UKPL" note card
2. Change:
   - Judul: `Materi UKPL - Updated`
   - Kategori: `Kerja`
   - Isi: `Updated content here`
3. Click "Simpan Perubahan"

**Expected:**
- [ ] Success SnackBar
- [ ] Navigate back to Dashboard
- [ ] Note shows updated title
- [ ] Category changed to orange "Kerja"

**Actual Result:** ________________

---

#### ✅ Test 2.11: Delete Note
**Steps:**
1. Click delete icon (🗑️) on "Daftar Belanja" note
2. Confirmation dialog appears
3. Click "Hapus"

**Expected:**
- [ ] Note removed from list
- [ ] Success SnackBar
- [ ] Only 2 notes remain

**Actual Result:** ________________

---

### Test Group 3: Profile Management

#### ✅ Test 3.1: View Profile
**Steps:**
1. Click profile icon in AppBar
2. Select "Profile"

**Expected:**
- [ ] Profile page opens
- [ ] Shows current user data:
   - Nama Lengkap field filled
   - Username field filled
   - Password field empty

**Actual Result:** ________________

---

#### ✅ Test 3.2: Update Profile - Name Only
**Steps:**
1. In Profile page
2. Change Nama Lengkap: `Updated Test User`
3. Leave password empty
4. Click "Simpan Perubahan"

**Expected:**
- [ ] Success SnackBar: "Profile berhasil diupdate"
- [ ] Navigate back
- [ ] No password changed (still can login with old password)

**Actual Result:** ________________

---

#### ✅ Test 3.3: Update Profile - Password
**Steps:**
1. In Profile page
2. Change Password: `newpass123`
3. Click "Simpan Perubahan"
4. Logout
5. Try login with old password

**Expected:**
- [ ] Old password doesn't work
- [ ] Login with new password works

**Actual Result:** ________________

---

#### ✅ Test 3.4: Update Profile - Username (Unique Check)
**Steps:**
1. Login as testuser
2. Go to Profile
3. Try change username to: `admin` (already exists)
4. Click "Simpan Perubahan"

**Expected:**
- [ ] Error SnackBar: "Username sudah digunakan"
- [ ] Profile not updated

**Actual Result:** ________________

---

### Test Group 4: Session Management

#### ✅ Test 4.1: Session Persistence
**Steps:**
1. Login as any user
2. Close app completely
3. Reopen app

**Expected:**
- [ ] Splash screen shows
- [ ] Auto-navigate to Dashboard (skip login)
- [ ] User still logged in
- [ ] Notes still visible

**Actual Result:** ________________

---

#### ✅ Test 4.2: Logout
**Steps:**
1. From Dashboard
2. Click profile icon → "Logout"
3. Confirm logout

**Expected:**
- [ ] Navigate to Login page
- [ ] Session cleared
- [ ] Restart app → goes to Login (not Dashboard)

**Actual Result:** ________________

---

### Test Group 5: Data Isolation

#### ✅ Test 5.1: User Data Isolation
**Steps:**
1. Login as `admin`
2. Create 2 notes
3. Logout
4. Login as `testuser`
5. View Dashboard

**Expected:**
- [ ] testuser sees only their own notes
- [ ] admin's notes NOT visible
- [ ] Empty state or only testuser's notes shown

**Actual Result:** ________________

---

### Test Group 6: About Us

#### ✅ Test 6.1: View About Page
**Steps:**
1. Click profile icon → "Tentang Kami"

**Expected:**
- [ ] About page opens
- [ ] Shows app info:
   - App name: catat.in
   - Version: 1.0.0
   - Creators:
     - Danang Adiwibowo
     - Gorga Doli Liberto Napitupulu

**Actual Result:** ________________

---

## 🔍 Edge Cases Testing

### ✅ Edge Case 1: Empty Fields Validation
**Steps:**
1. Try register with empty username
2. Try create note with empty title

**Expected:**
- [ ] Validation error: "Field tidak boleh kosong"
- [ ] Form doesn't submit

**Actual Result:** ________________

---

### ✅ Edge Case 2: Short Password
**Steps:**
1. Register with password: `12345` (5 chars)

**Expected:**
- [ ] Validation error: "Password minimal 6 karakter"

**Actual Result:** ________________

---

### ✅ Edge Case 3: Long Content
**Steps:**
1. Create note with 500+ words content

**Expected:**
- [ ] Note saves successfully
- [ ] Dashboard shows truncated preview
- [ ] Full content visible in edit page

**Actual Result:** ________________

---

### ✅ Edge Case 4: Special Characters
**Steps:**
1. Create note with title: `Test @#$%^&*()`

**Expected:**
- [ ] Saves without error
- [ ] Displays correctly

**Actual Result:** ________________

---

## 🎯 Performance Testing

### ✅ Performance 1: App Startup Time
**Measure:**
- [ ] Cold start: < 3 seconds
- [ ] Splash to Login: ~2 seconds
- [ ] Login to Dashboard: < 1 second

**Actual:** ________________

---

### ✅ Performance 2: Database Operations
**Measure:**
- [ ] Create note: < 500ms
- [ ] Load 50 notes: < 1 second
- [ ] Delete note: < 300ms

**Actual:** ________________

---

## 📱 Platform Testing

### ✅ Windows
- [ ] App runs
- [ ] FFI initialized (check console log)
- [ ] All features work
- [ ] Database persists

---

### ✅ Android
- [ ] App installs
- [ ] Native SQLite used
- [ ] All features work
- [ ] Database persists

---

### ✅ Web (Optional)
- [ ] App runs in Chrome
- [ ] Storage works
- [ ] Basic features work

---

## 🐛 Bug Report Template

If bug found:

**Bug ID:** ______  
**Severity:** Low / Medium / High / Critical  
**Test Case:** ______  
**Steps to Reproduce:**
1. 
2. 
3. 

**Expected Behavior:** ______  
**Actual Behavior:** ______  
**Screenshot/Log:** ______  
**Platform:** ______  

---

## ✅ Final Checklist

- [ ] All authentication tests passed
- [ ] All CRUD tests passed
- [ ] All filter/sort tests passed
- [ ] Profile management works
- [ ] Session persistence works
- [ ] Data isolation verified
- [ ] No crashes
- [ ] No error messages
- [ ] Performance acceptable
- [ ] UI responsive

---

## 📊 Test Summary

**Total Tests:** 30+  
**Passed:** _____ / 30  
**Failed:** _____ / 30  
**Blocked:** _____ / 30  

**Pass Rate:** _____%

**Status:** 
- [ ] ✅ Ready for Production
- [ ] ⚠️ Needs Minor Fixes
- [ ] ❌ Major Issues Found

---

**Tester Name:** ________________  
**Date:** ________________  
**Platform Tested:** ________________  
**Flutter Version:** ________________  

---

## 🎉 Sign Off

- [ ] All critical features working
- [ ] No blocking bugs
- [ ] Performance acceptable
- [ ] Ready for demo/submission

**Approved By:** ________________  
**Date:** ________________  

---

**Notes:**  
Use this checklist setiap kali testing untuk ensure quality!
Save hasil testing untuk documentation.
