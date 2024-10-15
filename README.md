# Türkçe
## Projede Kullanılan Yapılar
### AuthManager
AuthManager, Firebase Authentication servisinin yönetimini sağlar. Bu sınıf, kullanıcı kayıt, giriş, çıkış işlemlerinin yanı sıra şifre sıfırlama ve e-posta doğrulama gibi işlemleri de içerir. Tüm bu işlemler, uygulamanın genelinde kolayca erişilebilmesi için tek bir sınıf altında toplanmıştır.

- Kullanıcı Kayıt: Yeni kullanıcı kaydını gerçekleştirir.
- Kullanıcı Giriş: Mevcut bir kullanıcının giriş yapmasını sağlar.
- Şifre Sıfırlama: Kullanıcının şifresini sıfırlamak için e-posta gönderir.
- E-posta Doğrulama: Kullanıcıya doğrulama e-postası gönderir.
### FirestoreManager
FirestoreManager, Firebase Firestore veritabanıyla ilgili işlemleri yönetir. Bu sınıf, post paylaşımlarını kaydetme, yorum ekleme ve postları çekme gibi işlemleri kapsar. Veritabanı işlemleri için merkezi bir yönetim sağlayarak veri akışını düzenler.

- Post Kaydetme: Kullanıcıların paylaştığı görsellerin URL'lerini ve metadata bilgilerini Firestore'a kaydeder.
- Post Çekme: Firestore veritabanında yer alan postları sıralı şekilde çeker ve liste halinde döner.
- Yorum Ekleme: Mevcut postlara kullanıcıların yorum eklemesini sağlar.
### StorageManager
StorageManager, Firebase Storage servisini kullanarak görsel yüklemelerini yönetir. Bu sınıf, kullanıcıların uygulamaya yükledikleri görselleri Firebase Storage'a kaydeder ve sonrasında bu görsellere ait URL'leri Firestore veritabanına kaydetmek üzere FirestoreManager ile iş birliği yapar.

- Görsel Yükleme: Kullanıcının seçtiği görseller Firebase Storage'a kaydedilir ve indirilebilir URL'leri oluşturulur.
### RemoteConfigManager
RemoteConfigManager, Firebase Remote Config servisini yönetir. Bu sınıf, uygulamanın uzaktan konfigürasyonunu sağlar. Uygulama içindeki dinamik değişiklikler (örneğin, başlık metnini değiştirme) bu yapı sayesinde sunucu üzerinden güncellenebilir.

-Remote Config Fetch: Sunucudan konfigürasyon verilerini çeker ve etkinleştirir.
-Başlık Getir: Uygulamanın dinamik başlık metnini döner.
-Başlık Gizliliği: Başlığın görünürlüğünü sunucudan aldığı veriye göre yönetir.

## Kullanılan Teknolojiler
- Firebase Authentication: Kullanıcı kimlik doğrulama işlemleri için.
- Firestore: Veritabanı işlemleri için.
- Firebase Storage: Görsel dosya yüklemeleri için.
- Firebase Remote Config: Dinamik uygulama ayarlarını yönetmek için.

# English
## Structures Used in the Project
### AuthManager
AuthManager provides management of Firebase Authentication service. This class includes user registration, login, logout operations as well as operations such as password reset and e-mail verification. All these operations are gathered under a single class for easy access throughout the application.

- User Registration: Performs new user registration.
- User Login: Allows an existing user to log in.
- Password Reset: Sends an email to reset the user's password.
- Email Verification: Sends a verification email to the user.
### FirestoreManager
FirestoreManager manages operations related to the Firebase Firestore database. This class covers operations such as saving posts, adding comments and pulling posts. It organizes the flow of data by providing a centralized management for database operations.

- Post Saving: Saves the URLs and metadata information of the images shared by users to Firestore.
- Post Pull: Pulls the posts in the Firestore database sequentially and returns them as a list.
- Add Comment: Allows users to add comments to existing posts.
#### StorageManager
StorageManager manages image uploads using the Firebase Storage service. This class saves the images that users upload to the application to Firebase Storage and then cooperates with FirestoreManager to save the URLs of these images to the Firestore database.

- Image Upload: User selected images are saved to Firebase Storage and their downloadable URLs are created.
### RemoteConfigManager
RemoteConfigManager manages the Firebase Remote Config service. This class enables remote configuration of the application. Dynamic changes within the application (for example, changing the header text) can be updated through the server thanks to this structure.

-Remote Config Fetch: Retrieves and activates configuration data from the server.
-Title Fetch: Returns the dynamic header text of the application.
-Title Privacy: Manages the visibility of the header according to the data received from the server.

## Technologies Used
- Firebase Authentication: For user authentication.
- Firestore: For database operations.
- Firebase Storage: For visual file uploads.
- Firebase Remote Config: For managing dynamic application settings.

