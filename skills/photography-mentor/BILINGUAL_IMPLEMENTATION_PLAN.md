# Photography Mentor Bilingual Implementation Plan

## Current State Analysis
- Existing knowledge base files are primarily in Chinese
- Core theory files: `core_theory.md`, `exposure_triangle.md`, `composition.md`, etc.
- Brand common files: `canon_common.md`, `sony_common.md`, etc.
- Model-specific files: `canon_eos_r5.md`, `sony_a7_iv.md`, etc.
- Scenario files: `portrait_photography.md`

## Bilingual Strategy Options

### Option 1: Separate Language Files (Recommended)
Create parallel file structure with language suffixes:
```
references/
├── core_theory_en.md
├── core_theory_zh.md
├── exposure_triangle_en.md
├── exposure_triangle_zh.md
├── canon_common_en.md
├── canon_common_zh.md
└── ...
```

**Advantages:**
- Clean separation of languages
- Easy to maintain and update
- Flexible for adding more languages later
- No performance impact from large bilingual files

**Disadvantages:**
- Double the number of files
- Requires language detection/routing logic

### Option 2: Bilingual Content in Single Files
Each file contains both English and Chinese content with clear section headers.

**Advantages:**
- Single source of truth
- Easier cross-reference between languages
- Users can compare translations easily

**Disadvantages:**
- Larger file sizes
- More complex parsing
- Potential for content drift between languages

### Option 3: Translation Layer
Keep original Chinese files and create a translation mapping system.

**Advantages:**
- Minimal changes to existing structure
- Translation can be added incrementally

**Disadvantages:**
- Complex implementation
- Harder to maintain consistency

## Recommended Approach: Option 1 (Separate Language Files)

### Implementation Steps

#### Phase 1: Core Theory Files
1. Create English versions of all core theory files
2. Update script logic to handle language selection
3. Test bilingual functionality

#### Phase 2: Brand Common Files  
4. Create English versions of brand common files
5. Ensure terminology consistency across brands

#### Phase 3: Model-Specific Files
6. Create English versions of model-specific files
7. Verify technical accuracy of translations

#### Phase 4: Scenarios and Utilities
8. Create English scenario files
9. Update all supporting scripts and documentation

### File Naming Convention
- `{filename}_en.md` for English
- `{filename}_zh.md` for Chinese (existing files can be renamed or kept as default)

### Language Detection Logic
The skill should:
1. Detect user's preferred language from query
2. Fall back to system default if ambiguous
3. Allow explicit language specification (e.g., "in English", "用中文")

### Quality Assurance
- Technical photography terms must be accurately translated
- Maintain consistent terminology across all files
- Preserve all technical details and specifications
- Ensure formatting consistency

## Sample Bilingual File Structure

### Example: core_theory_en.md vs core_theory_zh.md

**core_theory_en.md:**
```markdown
# Photography Core Theory

## Exposure Triangle Theory

### What is the Exposure Triangle?
The exposure triangle is the most fundamental concept in photography, consisting of three interrelated elements:
- **Aperture**: Controls light intake and depth of field
- **Shutter Speed**: Controls exposure time and motion blur
- **ISO Sensitivity**: Controls sensor sensitivity to light
...
```

**core_theory_zh.md:**
```markdown
# 摄影核心理论

## 曝光三角理论

### 什么是曝光三角？
曝光三角是摄影中最基础的概念，由三个相互关联的要素组成：
- **光圈 (Aperture)**：控制进光量和景深
- **快门速度 (Shutter Speed)**：控制曝光时间和运动模糊  
- **ISO感光度**：控制传感器对光的敏感度
...
```

## Timeline and Resources

### Estimated Effort
- Core theory files: 2-3 days
- Brand common files: 3-5 days  
- Model-specific files: 5-7 days
- Testing and QA: 2-3 days
- Total: 2-3 weeks

### Resource Requirements
- Native English speaker with photography expertise
- Technical review by photography professionals
- Consistency checking across all files

## Success Metrics
- All knowledge base files available in both languages
- Accurate technical translations
- Consistent terminology across languages
- Seamless user experience regardless of language preference