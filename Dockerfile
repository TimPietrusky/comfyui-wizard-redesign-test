# clean base image containing only comfyui, comfy-cli and comfyui-manager
FROM runpod/worker-comfyui:5.8.4-base

# build-time tokens for gated downloads — never baked into final image.
# pass via: docker build --build-arg HF_TOKEN=$HF_TOKEN ...
ARG HF_TOKEN=""
ARG CIVITAI_API_KEY=""

# install custom nodes into comfyui
RUN comfy node install --exit-on-fail comfyui-animatediff-evolved --mode remote

# download models into comfyui
RUN HF_TOKEN=$HF_TOKEN comfy model download --url 'https://huggingface.co/stabilityai/sd-vae-ft-mse-original/resolve/main/vae-ft-mse-840000-ema-pruned.safetensors' --relative-path models/vae --filename 'vae-ft-mse-840000-ema-pruned.ckpt'
RUN CIVITAI_API_KEY=$CIVITAI_API_KEY comfy model download --url 'https://civitai.com/api/download/models/93208' --relative-path models/checkpoints --filename 'Anime - darkSushiMixMix_colorful.safetensors'
RUN HF_TOKEN=$HF_TOKEN comfy model download --url 'https://huggingface.co/guoyww/animatediff/resolve/main/mm_sd_v15_v2.ckpt' --relative-path models/animatediff_models --filename 'mm_sd_v15_v2.ckpt'
