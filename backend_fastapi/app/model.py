import torch
import torch.nn as nn
import timm

class XceptionFrozenBN(nn.Module):
    def __init__(self):
        super().__init__()
        # Create base Xception model, pretrained, with no classifier head (num_classes=0)
        self.base = timm.create_model('xception', pretrained=True, num_classes=0)
        feat_dim = self.base.num_features
        
        # Classification head matching notebook v7 configuration
        self.head = nn.Sequential(
            nn.Linear(feat_dim, 512),
            nn.BatchNorm1d(512),
            nn.ReLU(inplace=True),
            nn.Dropout(0.4),
            nn.Linear(512, 128),
            nn.BatchNorm1d(128),
            nn.ReLU(inplace=True),
            nn.Dropout(0.2),
            nn.Linear(128, 1)
        )
        
        # Cache list of BatchNorm layers inside the base model
        self._base_bn_layers = [
            m for m in self.base.modules()
            if isinstance(m, (nn.BatchNorm2d, nn.BatchNorm1d))
        ]
        self._freeze_base()

    def _freeze_base(self):
        """Freezes parameters in the base Xception model."""
        for p in self.base.parameters():
            p.requires_grad = False

    def unfreeze_base(self, n_params=None):
        """Helper to unfreeze layers of the base model if needed."""
        if n_params is None:
            for p in self.base.parameters():
                p.requires_grad = True
        else:
            for p in self.base.parameters():
                p.requires_grad = False
            params = list(self.base.parameters())
            for p in params[-n_params:]:
                p.requires_grad = True

    def train(self, mode=True):
        """BatchNorm base layers always stay in eval() mode to freeze running stats

        even if parameters in the base model are unfrozen during training.
        """
        super().train(mode)
        if mode:
            for bn in self._base_bn_layers:
                bn.eval()
        return self

    def forward(self, x):
        features = self.base(x)
        return self.head(features)
