#!/bin/bash

echo "=== RAG 평가 프로젝트 환경 세팅 시작 ==="

cd /workspace

# 프로젝트 폴더가 없으면 GitHub에서 clone, 있으면 최신 코드 pull
if [ ! -d "/workspace/rag-eval-practice" ]; then
    echo "프로젝트 폴더가 없어서 GitHub에서 clone 합니다."
    git clone https://github.com/juyoo0729/rag-eval-practice.git
else
    echo "프로젝트 폴더가 이미 있어서 git pull 합니다."
    cd /workspace/rag-eval-practice
    git pull
fi

cd /workspace/rag-eval-practice

# 가상환경 생성
if [ ! -d ".venv" ]; then
    python -m venv .venv
fi

# 가상환경 활성화
source .venv/bin/activate

# pip 업그레이드
python -m pip install -U pip

# requirements.txt 기준 패키지 설치
python -m pip install -r requirements.txt

# Jupyter 커널 등록
python -m ipykernel install --user --name rag-env --display-name "Python (rag-env)"

# 필요한 폴더 생성
mkdir -p data
mkdir -p results
mkdir -p vectorstore
mkdir -p notebooks
mkdir -p src

echo "=== 환경 세팅 완료 ==="
echo "JupyterLab에서 커널을 Python (rag-env)로 선택하세요."