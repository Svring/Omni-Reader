from sdparsers import ParserManager
from PIL import Image
import json


def convert_keys_to_strings(dictionary):
    new_dict = {}
    for key, value in dictionary.items():
        if isinstance(value, dict):
            new_value = convert_keys_to_strings(value)  # 递归调用处理嵌套的字典
        else:
            new_value = value
        new_dict[str(key)] = new_value
    return new_dict


def convert_dict_to_strings(dictionary):
    """
    递归函数，将字典中所有的键和值转换为字符串类型
    """
    new_dict = {}
    for key, value in dictionary.items():
        if isinstance(value, dict):
            new_value = convert_dict_to_strings(value)  # 递归调用处理嵌套的字典
        else:
            new_value = str(value)
        new_dict[str(key)] = new_value
    return new_dict


def parse(image):
    parser_manager = ParserManager()
    # extract metadata from image
    prompt_info = parser_manager.parse(image)
    generator = prompt_info.generator
    if generator == 'AUTOMATIC1111':
        return parseAuto(image)
    elif generator == 'NovelAI':
        return parseNovel(image)
    elif generator == 'ComfyUI':
        return parseComfy(image)


def parseAuto(image):
    parser_manager = ParserManager()
    # extract metadata from image
    prompt_info = parser_manager.parse(image)
    generator = prompt_info.generator
    positive_prompt = prompt_info.prompts[0][0].value
    negative_prompt = prompt_info.prompts[0][1].value
    sampler_name = prompt_info.samplers[0][0]
    step = prompt_info.samplers[0][1]['steps']
    cfg_scale = prompt_info.samplers[0][1]['cfg_scale']
    seed = prompt_info.samplers[0][1]['seed']
    model_name = prompt_info.models[0].name
    model_hash = prompt_info.models[0].model_hash
    size = prompt_info.metadata['size']
    metadata = prompt_info.metadata
    raw_params = prompt_info.raw_params

    # return metadata as dictionary
    dictionary = {
        "generator": generator,
        "positivePrompt": positive_prompt,
        "negativePrompt": negative_prompt,
        "samplerName": sampler_name,
        "step": step,
        "cfgScale": cfg_scale,
        "seed": seed,
        "modelName": model_name,
        "modelHash": model_hash,
        "size": size,
        "metadata": metadata,
        "rawParams": raw_params,
    }

    return json.dumps(dictionary)


def parseNovel(image):
    parser_manager = ParserManager()
    prompt_info = parser_manager.parse(image)
    generator = prompt_info.generator
    positive_prompt = prompt_info.prompts[0][0].value
    negative_prompt = prompt_info.prompts[0][1].value
    sampler_name = prompt_info.samplers[0][0]
    step = prompt_info.metadata['steps']
    cfg_scale = prompt_info.samplers[0][1]['scale']
    seed = prompt_info.samplers[0][1]['seed']
    model_name = prompt_info.models[0].name
    model_hash = prompt_info.models[0].model_hash
    height = prompt_info.metadata['height']
    width = prompt_info.metadata['width']
    size = str(height) + 'x' + str(width)
    metadata = prompt_info.metadata
    raw_params = prompt_info.raw_params

    dictionary = {
        "generator": generator,
        "positivePrompt": positive_prompt,
        "negativePrompt": negative_prompt,
        "samplerName": sampler_name,
        "step": step,
        "cfgScale": cfg_scale,
        "seed": seed,
        "modelName": model_name,
        "modelHash": model_hash,
        "size": size,
        "metadata": convert_dict_to_strings(metadata),
        "rawParams": convert_dict_to_strings(raw_params),
    }

    dictionary = {
        key: str(value) if key not in ("metadata", "rawParams") else value
        for key, value in dictionary.items()
    }

    return json.dumps(dictionary)


def parseComfy(image):
    parser_manager = ParserManager()
    prompt_info = parser_manager.parse(image)
    generator = prompt_info.generator
    positive_prompt = ''
    negative_prompt = ''
    sampler_name = ''
    step = ''
    cfg_scale = ''
    seed = ''
    model_name = ''
    model_hash = ''
    size = ''
    metadata = prompt_info.metadata
    raw_params = prompt_info.raw_params
    
    dictionary = {
        "generator": generator,
        "positivePrompt": positive_prompt,
        "negativePrompt": negative_prompt,
        "samplerName": sampler_name,
        "step": step,
        "cfgScale": cfg_scale,
        "seed": seed,
        "modelName": model_name,
        "modelHash": model_hash,
        "size": size,
        "metadata": convert_dict_to_strings(metadata),
        "rawParams": convert_dict_to_strings(raw_params),
        "workflow": raw_params['workflow']
    }

    return json.dumps(dictionary)


if __name__ == '__main__':
    path = "/Users/linkling/main/Artificial/sd-image-info/scripts/images/comfy.png"
    with Image.open(path) as image:
        metadata = parse(image)
    print(type(metadata))
