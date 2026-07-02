#!/usr/bin/env python3
"""
Photography Mentor Knowledge Query Example
Demonstrates how to query knowledge across multiple camera brands.
"""

def query_photography_knowledge(query_type, brand=None, model=None, topic=None):
    """
    Query photography knowledge with inheritance support
    
    Args:
        query_type: "core_theory", "brand_common", "model_specific", "scenario"
        brand: Camera brand (canon, sony, nikon, fujifilm, panasonic, om_system, leica)
        model: Specific camera model
        topic: Specific topic or feature
        
    Returns:
        Combined knowledge from relevant sources
    """
    
    # Core theory is universal
    if query_type == "core_theory":
        return load_core_theory(topic)
    
    # Brand common knowledge
    elif query_type == "brand_common" and brand:
        return load_brand_common(brand, topic)
    
    # Model specific knowledge with inheritance
    elif query_type == "model_specific" and brand and model:
        # Load brand common first
        brand_knowledge = load_brand_common(brand, topic)
        # Load model specific overrides
        model_knowledge = load_model_specific(brand, model, topic)
        # Combine with model-specific taking precedence
        return combine_knowledge(brand_knowledge, model_knowledge)
    
    # Scenario-based guidance
    elif query_type == "scenario" and topic:
        return load_scenario_guidance(topic, brand, model)
    
    else:
        return "Please specify query parameters"

def load_core_theory(topic):
    """Load universal photography principles"""
    core_files = {
        "exposure": "references/exposure_triangle.md",
        "composition": "references/composition.md", 
        "lighting": "references/lighting.md",
        "color": "references/color_theory.md",
        "focus": "references/focus_techniques.md"
    }
    return read_file(core_files.get(topic, "references/core_theory.md"))

def load_brand_common(brand, topic):
    """Load brand-specific common operations"""
    brand_files = {
        "canon": "references/canon_common.md",
        "sony": "references/sony_common.md", 
        "nikon": "references/nikon_common.md",
        "fujifilm": "references/fujifilm_common.md",
        "panasonic": "references/panasonic_common.md",
        "om_system": "references/om_system_common.md"
    }
    return read_file(brand_files.get(brand, f"references/{brand}_common.md"))

def load_model_specific(brand, model, topic):
    """Load model-specific features and differences"""
    # Convert model name to filename format
    model_file = f"references/{brand}_{model.replace('-', '_').replace(' ', '_').lower()}.md"
    return read_file(model_file)

def combine_knowledge(brand_knowledge, model_knowledge):
    """Combine brand common and model specific knowledge"""
    # In a real implementation, this would merge the content intelligently
    # with model-specific information overriding brand-common where applicable
    return f"{brand_knowledge}\n\n--- MODEL SPECIFIC ---\n{model_knowledge}"

def read_file(filepath):
    """Read file content with error handling"""
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            return f.read()
    except FileNotFoundError:
        return f"File not found: {filepath}"
    except Exception as e:
        return f"Error reading file: {e}"

# Example usage
if __name__ == "__main__":
    # Query portrait photography settings for Fujifilm X-T5
    result = query_photography_knowledge(
        query_type="scenario", 
        brand="fujifilm", 
        model="xt5", 
        topic="portrait_photography"
    )
    print(result)