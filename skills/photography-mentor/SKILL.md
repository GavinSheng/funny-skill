---
name: photography-mentor
description: Comprehensive photography learning and camera operation guide supporting all major camera brands including Canon, Sony, Nikon, Fujifilm, Panasonic, OM System, Leica, Hasselblad, Pentax, Ricoh, GoPro, DJI, and Insta360. Provides structured learning paths for beginners and advanced technical guidance for experienced photographers. Use when users need help with: (1) Learning photography fundamentals, (2) Operating specific camera models, (3) Solving shooting technique problems, (4) Understanding camera-specific features and settings.
---

# Photography Mentor Skill / 摄影导师技能

## Overview / 概述

This skill provides structured photography education and camera-specific operational guidance for all major camera systems including DSLR, mirrorless, medium format, compact, and action cameras. It combines universal photography theory with brand-specific and model-specific operational knowledge.

本技能为所有主流相机系统（包括单反、微单、中画幅、便携和运动相机）提供结构化的摄影教育和相机专属操作指导。它结合了通用摄影理论与品牌专属和型号专属的操作知识。

## Core Capabilities

### Learning Paths
- **Beginner Path**: Exposure triangle → Camera basics → Composition → Lighting → Practical scenarios
- **Intermediate Path**: Advanced exposure → Depth of field → Focusing techniques → White balance → Creative composition
- **Expert Consultation**: Model-specific feature queries and problem-solving

### Supported Cameras
- **Canon**: EOS 5D Mark III, EOS R5, EOS R5 Mark II, EOS R6 Mark III, EOS R3, EOS R6 Mark II, EOS R8, EOS R7, EOS 90D, **EOS R1 (2025)**
- **Sony**: Alpha A7C II, Alpha A7 IV, Alpha A7R V, Alpha A9 III, Alpha A1, Alpha A7C, Alpha A7R IV, **Alpha A7C III (2025)**, **Alpha A7S IV (2025)**
- **Nikon**: Z8, Z6 II, Z7 II, Zf, Z9, Z6 III, **Z9 Mark II (2026)**
- **Panasonic**: S5 II, S5 IIX, S1H, S1R, S1, **S5 III (2025)**, **S1 Mark II (2026)**
- **Leica**: SL2, SL2-S, Q3, **SL3 (2025)**
- **Sigma**: fp, fp L, **fp Mark II (2026)**
- **Fujifilm**: X-T5, X-H2, X-H2S, GFX 100 II (medium format), X-T4
- **OM System** (Olympus): OM-1 Mark II, OM-5, OM-1, E-M1 Mark III, E-M5 Mark III
- **Hasselblad**: X2D 100C, 907X & CFV 100C, X1D II 50C, X1D 50C, H6D-100c
- **Pentax**: K-3 Mark III, K-1 Mark II, KP, K-70, Q

### Knowledge Structure
- **Core Theory**: Universal photography principles (exposure, composition, lighting, color)
- **Brand Common**: Brand-specific operational logic and menu systems
- **Model Specific**: Unique features and differences for each camera model
- **Practical Scenarios**: Real-world shooting situations and techniques

## Usage Patterns

### Systematic Learning
When users want to learn photography systematically, provide structured lessons following the appropriate learning path based on their experience level.

### Camera-Specific Queries  
When users ask about specific camera operations (e.g., "How do I set up 8K video on my R5 Mark II?"), combine brand common knowledge with model-specific differences.

### Problem Solving
When users have specific shooting problems (e.g., "Why is my snow photos gray?"), provide both theoretical explanation and camera-specific solution steps.

## Resource Organization

### References
- `references/core_theory/`: Universal photography principles
- `references/canon/`: Canon brand common operations  
- `references/sony/`: Sony brand common operations
- `references/nikon/`: Nikon brand common operations
- `references/models/`: Model-specific differences and features
- `references/scenarios/`: Practical shooting scenarios

### Scripts
- `scripts/query_knowledge.py`: Knowledge query engine with inheritance support
- `scripts/generate_lesson.py`: Lesson generation for systematic learning
- `scripts/parse_manual.py`: User-uploaded manual parsing and indexing

### Assets
- `assets/manuals/`: Directory for user-uploaded camera manuals (PDF/DOC)

## Progressive Disclosure

For detailed information, consult the appropriate reference files:

- **Camera operation details**: See `references/[brand]/` directories
- **Model-specific features**: See `references/models/[model]/` directories  
- **Shooting scenarios**: See `references/scenarios/` directory
- **Technical specifications**: Included in model-specific reference files

The skill uses an inheritance-based architecture where model-specific content builds upon brand-common knowledge, avoiding redundancy while ensuring accuracy.