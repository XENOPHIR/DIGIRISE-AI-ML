Authentication & RBAC System Design Document
============================================

### Requirements

*   User authentication via OAuth2
*   Role-based access control (Operator, Scientist, Admin)
*   Session management
*   User profile management
*   Secure password storage and transmission

#

![Authorization and RBAC](<../DIAGRAMS/PNG/Authorization and RBAC.png>) 


## **Flow Overview**

### **1. User Request Initiation**  
- A **user** makes an API request to access a service.  
- The request is first routed through the **API Gateway**.  
- The **API Gateway** forwards the request to the **App Server** for authentication.  

### **2. OAuth2 Authentication**  
- The **App Server** communicates with the **OAuth2 Authentication Service** to verify user credentials.  
- If credentials are **valid**, token validation begins.  

### **3. Token Validation**  
#### **Does the User Have an Access Token?**  
- **Yes → Check if the token has expired.**  
- **No → Check for a refresh token.**  

#### **Has the Access Token Expired?**  
- **No → Proceed to role validation.**  
- **Yes → Check if a refresh token exists.**  

### **4. Refresh Token Handling**  
- If the access token has expired, the system checks for a **refresh token**:  
  - **Valid Refresh Token?**  
    - **Yes → Generate a new access token.**  
    - **No → 401 Unauthorized (User must log in again).**  
  - If the **refresh token itself is expired**, the user must **re-authenticate**.  

### **5. Role-Based Access Control (RBAC)**  
- If the access token is valid, the system checks the **user’s role**:  
  - **Valid Role → Access Granted.**  
  - **Invalid Role → 403 Forbidden.**  

### **6. Accessing System Services**  
- If access is granted, the user is redirected to the appropriate system service:  
  - **Admins:** Manage Users & Reports  
  - **Scientists:** View Analytics & Water Data  
  - **Operators:** Access Dashboard & Notifications  
  - Other connected services include:
    - **RabbitMQ (Message Broker)**  
    - **Notification Service**  
    - **Predictive Analytics Service**  
    - **Monitoring Service**  
    - **PostgreSQL Database & Redis Cache**  

---

## **Error Handling**  
| Condition | Response Code | Action Required |  
|-----------|--------------|----------------|  
| Invalid credentials | `401 Unauthorized` | User must log in again |  
| No access/refresh token | `401 Unauthorized` | User must re-authenticate |  
| Expired refresh token | `401 Unauthorized` | User must log in again |  
| Invalid role | `403 Forbidden` | Access denied |  

---

## **Technologies Used**  
- **OAuth2** for secure authentication  
- **API Gateway** for request routing  
- **PostgreSQL & Redis** for token storage and caching  
- **RabbitMQ** for message brokering


## **Calculations**

### Constraints
*   Support 1 million active users
*   Authentication response time < 200ms
*   Token validation < 50ms
*   99.99% availability

    

### Capacity Planning
*   Daily active users: 1M
*   Peak concurrent users: 100K
*   Average session duration: 8 hours
*   Token size: ~1KB
*   User profile size: ~2KB
        

### Data Storage

1.  **User Store (PostgreSQL)**
    *   User profiles
    *   Authentication data
    *   Scaling: Read replicas
    *   Size: ~3GB (1M users \* 3KB)
2.  **Session Store (Redis)**
    *   Active sessions
    *   Token blacklist
    *   Scaling: Redis cluster
    *   Size: ~100MB (100K sessions \* 1KB)


Scale & Performance
-----------------------

### Scalability
*   Horizontal scaling of Authentication service
*   Redis cluster for session management
*   Database read replicas