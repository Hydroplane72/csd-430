Select one of the topics below. Then, answer the “what,” “how,” and “why” questions below about your selected topic. Provide a simple code or code snippet example to further illustrate your thoughts.

# Topic: Store data securely

## What:

Storing data securely is about protecting sensitive information from unauthorized access. This can be achieved through various methods such as encryption, access controls, and secure storage solutions. The goal is to ensure that even if unauthorized individuals access the data, it remains unreadable and unusable without the proper decryption key or access permissions. 

## How:
To store data securely, one common approach is to use encryption. This involves converting the original data (plaintext) into an unreadable format (ciphertext) using an encryption algorithm and a secret key. Only those with the correct key can decrypt the data back to its original form. Additionally, implementing access controls and using secure storage solutions (like encrypted databases or secure cloud storage) can further enhance data security.

Over the years, I have seen all sorts of different approaches to storing data. Some of them have been more secure than others. The easiest to extract data from is Access Databases. At the same time, you can encrypt the database and set a password. The way they stored the password in the MDB file is not secure at all. You can easily extract the password and decrypt the database (the tool I used at my last job only cost $100). One of the few databases that I had trouble extracting data from was Claris FileMaker Pro. The main reason for this is that the only reasonable way to extract data from a FileMaker Pro database is to use the FileMaker Pro application itself. The cost of the application is prohibitive for a company built primarily on the ability to quickly, cheaply, and reliably extract data from databases. With that said, you will be in the world of hurt if you rely on FileMaker Pro for secure data storage. At some point, you will need to extract data from the database, and if you do not have the application, you will be out of luck. The best way to store data securely is to use a modern database that has built-in encryption and access controls. This way, you can ensure that your data is protected even if it falls into the wrong hands.

## Why:
Storing data securely is crucial to protect sensitive information such as personal data, financial information, and intellectual property. It helps prevent data breaches, identity theft, and unauthorized access that can lead to financial loss, reputational damage, and legal consequences. By ensuring data is stored securely, organizations can maintain customer trust and comply with data protection regulations.

## Java Code example of storing data securely using encryption:

```java
import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import java.util.Base64;

public class SecureDataStorage {

    private static final String ALGORITHM = "AES";

    public static void main(String[] args) throws Exception {
        String dataToStore = "Sensitive Data";
        SecretKey secretKey = generateSecretKey();

        // Encrypt the data
        String encryptedData = encrypt(dataToStore, secretKey);
        System.out.println("Encrypted Data: " + encryptedData);

        // Decrypt the data
        String decryptedData = decrypt(encryptedData, secretKey);
        System.out.println("Decrypted Data: " + decryptedData);
    }

    private static SecretKey generateSecretKey() throws Exception {
        KeyGenerator keyGenerator = KeyGenerator.getInstance(ALGORITHM);
        keyGenerator.init(128); // AES-128
        return keyGenerator.generateKey();
    }

    private static String encrypt(String data, SecretKey secretKey) throws Exception {
        Cipher cipher = Cipher.getInstance(ALGORITHM);
        cipher.init(Cipher.ENCRYPT_MODE, secretKey);
        byte[] encryptedBytes = cipher.doFinal(data.getBytes());
        return Base64.getEncoder().encodeToString(encryptedBytes);
    }

    private static String decrypt(String encryptedData, SecretKey secretKey) throws Exception {
        Cipher cipher = Cipher.getInstance(ALGORITHM);
        cipher.init(Cipher.DECRYPT_MODE, secretKey);
        byte[] decryptedBytes = cipher.doFinal(Base64.getDecoder().decode(encryptedData));
        return new String(decryptedBytes);
    }
}
```