#ifndef NX_USER_H
#define NX_USER_H

// Disable the weird includes in some of the source files
#ifndef NX_DISABLE_INCLUDE_SOURCE_CODE
#define NX_DISABLE_INCLUDE_SOURCE_CODE
#endif

// Copied from nx_user_sample.h
#if (defined(NX_TCP_IMMEDIATE_ACK) && !defined(NX_TCP_ACK_EVERY_N_PACKETS))
#define NX_TCP_ACK_EVERY_N_PACKETS 1
#endif

#endif // NX_USER_H