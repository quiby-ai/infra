-- Initialize required extensions for pgvector and pgcrypto
CREATE EXTENSION IF NOT EXISTS vector;     -- pgvector for vector operations
CREATE EXTENSION IF NOT EXISTS pgcrypto;   -- for gen_random_uuid() and cryptographic functions
