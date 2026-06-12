import io
from PIL import Image
import torch
from torchvision import transforms

def preprocess_image(image_bytes: bytes) -> torch.Tensor:
    """Preprocesses raw image bytes into a PyTorch tensor.

    Steps:
    1. Loads raw bytes into a PIL Image.
    2. Converts image to RGB mode.
    3. Resizes image to 299x299 pixels.
    4. Converts to Tensor and normalizes using ImageNet mean & std.
    5. Adds batch dimension.
    """
    image = Image.open(io.BytesIO(image_bytes)).convert("RGB")
    
    transform = transforms.Compose([
        transforms.Resize((299, 299)),
        transforms.ToTensor(),
        transforms.Normalize(
            mean=[0.485, 0.456, 0.406],
            std=[0.229, 0.224, 0.225]
        )
    ])
    
    # Transform image and add batch dimension (B=1, C=3, H=299, W=299)
    tensor = transform(image).unsqueeze(0)
    return tensor
