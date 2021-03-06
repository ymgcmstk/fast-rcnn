#!/bin/bash

set -x
set -e

export PYTHONUNBUFFERED="True"

LOG="experiments/logs/whole_vgg16.txt.`date +'%Y-%m-%d_%H-%M-%S'`"
exec &> >(tee -a "$LOG")
echo Logging output to "$LOG"

time ./tools/train_net.py --gpu $1 \
  --solver models/VGG16_whole/solver.prototxt \
  --weights data/imagenet_models/VGG16.v2.caffemodel \
  --imdb voc_2007_trainval \
  --cfg experiments/cfgs_whole/whole.yml

time ./tools/test_net.py --gpu $1 \
  --def models/VGG16_whole/test.prototxt \
  --net output/whole/voc_2007_trainval/vgg16_fast_rcnn_whole_iter_40000.caffemodel \
  --imdb voc_2007_test \
  --cfg experiments/cfgs_whole/whole.yml
