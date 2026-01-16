# Security & Configuration Management Guide

## Overview

This document outlines the security best practices and configuration management approach for the Eko Flutter application. The application uses compile-time constants via `dart-define` for maximum security and CI/CD compatibility.

## Configuration Architecture

### **Recommended Approach: dart-define**

We use `dart-define` for all sensitive configuration because it provides:

- ✅ **Compile-time safety**: Impossible to compile without required variables
- ✅ **CI/CD compatibility**: Perfect for pipeline secrets management
- ✅ **Security**: Values embedded in compiled binary (harder to extract)
- ✅ **Industry standard**: Flutter's recommended approach for production apps

### **Security Comparison**

| Method | Security | CI/CD Friendly | Compile-time Safety | Reverse Engineering Difficulty |
|--------|----------|----------------|---------------------|-------------------------------|
| `dart-define` | ⭐⭐⭐⭐ | ✅ | ✅ | Hard (requires binary analysis) |
| `.env` files | ⭐⭐ | ❌ | ❌ | Easy (file access) |
| Hardcoded | ⭐ | ❌ | ❌ | Trivial (source code) |

## Required Environment Variables

### **Critical (Must be provided)**
- `HUME_API_KEY`: Hume AI API key
- `HUME_CONFIG_ID`: Hume AI configuration ID  
- `OPENAI_API_KEY`: OpenAI API key

### **Optional (Has defaults)**
- `HUME_API_BASE_URL`: Default: `https://api.hume.ai`
- `HUME_WEBSOCKET_URL`: Default: `wss://api.hume.ai/v0/evi/chat`
- `OPENAI_API_BASE_URL`: Default: `https://api.openai.com`
- `OPENAI_MODEL`: Default: `gpt-4o-mini`
- `AUDIO_SAMPLE_RATE`: Default: `48000`
- `AUDIO_ENCODING`: Default: `linear16`
- `HTTP_TIMEOUT_SECONDS`: Default: `30`

## Usage Examples

### **Local Development**
```bash
# Copy the example file
cp .env.example .env.local

# Edit with your values
nano .env.local

# Run the app
./scripts/run-local.sh
```

### **Manual Build**
```bash
flutter build apk --release \
  --dart-define=HUME_API_KEY=your_key \
  --dart-define=HUME_CONFIG_ID=your_config \
  --dart-define=OPENAI_API_KEY=your_openai_key
```

### **CI/CD Pipeline**
See `.github/workflows/flutter.yml` for complete CI/CD implementation using GitHub Secrets.

## Security Best Practices

### **1. Secret Management**
- ✅ Use CI/CD secrets (GitHub Secrets, GitLab CI/CD variables, etc.)
- ✅ Never commit `.env` files to version control
- ✅ Rotate API keys regularly
- ✅ Use principle of least privilege for API keys

### **2. Build Security**
- ✅ Always use `--release` mode for production builds
- ✅ Enable code obfuscation: `flutter build apk --release --obfuscate`
- ✅ Sign your builds properly
- ✅ Use build provenance and integrity checks

### **3. Runtime Security**
- ✅ Validate all API responses
- ✅ Implement proper error handling
- ✅ Use certificate pinning for critical APIs
- ✅ Monitor for unusual API usage patterns

### **4. Development Security**
- ✅ Use different API keys for development vs production
- ✅ Implement API key usage quotas and limits
- ✅ Regular security audits of dependencies
- ✅ Keep Flutter and dependencies updated

## Reverse Engineering Protection

### **Current Protection Level**
With `dart-define`, secrets are embedded as compile-time constants in the binary:

```dart
static const String apiKey = String.fromEnvironment('API_KEY');
```

This makes extraction require:
1. Binary decompilation (APK/IPA analysis)
2. Static analysis of compiled Dart code
3. Memory dumping at runtime

### **Additional Protection Options**
For even higher security:

1. **Code Obfuscation**
   ```bash
   flutter build apk --release --obfuscate --split-debug-info=build/debug-info/
   ```

2. **Runtime Decryption** (Advanced)
   - Store encrypted values
   - Decrypt at runtime using device-specific keys
   - More complex but provides better protection

3. **Server-side Proxy**
   - Move API calls to a backend service
   - App authenticates with backend, backend manages API keys
   - Highest security but adds architectural complexity

## Environment Setup

### **Development Environment**
```bash
# Create local environment file
cp .env.example .env.local

# Edit with your development keys
# Use separate development API keys
```

### **Production Environment**
```bash
# Use CI/CD secrets or secure environment management
# Never store production keys in .env files
```

## Troubleshooting

### **Common Issues**

1. **"Missing required environment variables"**
   - Ensure all required variables are provided via `--dart-define`
   - Check CI/CD secret configuration

2. **Build fails with missing constants**
   - This is intentional - the app cannot compile without required secrets
   - Provides security guarantee that no build is released without proper configuration

3. **API authentication failures**
   - Verify API key validity and permissions
   - Check if keys are for correct environment (dev/prod)
   - Ensure API endpoints are correct

### **Debugging Configuration**
```dart
// Add this to debug configuration (remove in production)
if (kDebugMode) {
  print('HUME_API_KEY: ${AppConfig.humeApiKey.isNotEmpty ? "SET" : "MISSING"}');
  print('OPENAI_API_KEY: ${AppConfig.openAiApiKey.isNotEmpty ? "SET" : "MISSING"}');
}
```

## Compliance Considerations

- **GDPR**: Ensure no personal data in API keys or configuration
- **SOC 2**: Maintain proper secret management and access controls
- **HIPAA**: If handling health data, ensure additional security measures

## Monitoring & Alerting

- Set up monitoring for API key usage
- Alert on unusual patterns or quota exhaustion
- Regular security audits of API access logs
- Monitor for failed builds due to missing configuration

## References

- [Flutter Environment Configuration](https://docs.flutter.dev/deployment/environment#declaring-build-environment-variables)
- [Security Best Practices for Flutter](https://docs.flutter.dev/security)
- [OWASP Mobile Security Guidelines](https://owasp.org/www-project-mobile-top-10/)