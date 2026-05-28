# RAG Evaluation Practice

RAG 파이프라인을 구축하고, RAGAS를 이용해 검색 및 답변 품질을 평가하는 실습 프로젝트입니다.

## 프로젝트 목표

이 프로젝트의 목표는 단순히 RAG를 실행하는 것이 아니라, 설정값에 따라 RAG 성능이 어떻게 달라지는지 실험하고 분석하는 것입니다.

주요 실험 항목은 다음과 같습니다.

* chunk size에 따른 검색 품질 비교
* chunk overlap에 따른 문맥 유지 효과 비교
* retriever의 k 값에 따른 검색 결과 비교
* RAGAS 지표를 이용한 답변 품질 평가
* faithfulness, answer relevancy, context precision, context recall 비교

## 프로젝트 구조

```text
rag-eval-practice/
├── notebooks/
│   └── ragas_eval.ipynb
├── src/
├── data/
│   └── .gitkeep
├── results/
│   └── .gitkeep
├── vectorstore/
│   └── .gitkeep
├── setup.sh
├── requirements.txt
├── .gitignore
└── README.md
```

## 폴더 설명

| 폴더           | 설명                      |
| ------------ | ----------------------- |
| notebooks/   | Jupyter Notebook 실험 파일  |
| src/         | Python 모듈 코드            |
| data/        | PDF, CSV 등 원본 데이터 저장 위치 |
| results/     | 평가 결과 CSV, 그래프 등 저장 위치  |
| vectorstore/ | Chroma 벡터DB 저장 위치       |

## 주의사항

다음 파일은 GitHub에 업로드하지 않습니다.

* PDF 원본 파일
* API 키
* `.env` 파일
* Chroma 벡터DB
* 모델 파일
* 대용량 데이터셋

API 키는 `.env` 파일 또는 환경변수로 관리합니다.

## 설치 방법

로컬 또는 RunPod 환경에서 다음 명령어로 패키지를 설치합니다.

```bash
python -m pip install -r requirements.txt
```

RunPod에서는 다음 명령어로 환경을 세팅할 수 있습니다.

```bash
bash setup.sh
```

## 실험 계획

### 1. Chunk Size 비교

같은 문서와 같은 질문을 사용하여 chunk size만 변경합니다.

| 실험 | chunk_size | chunk_overlap |  k |
| -- | ---------: | ------------: | -: |
| A  |        500 |            50 |  3 |
| B  |       1000 |           100 |  3 |
| C  |       1500 |           150 |  3 |

### 2. Retriever k 값 비교

같은 chunk size에서 검색 문서 개수만 변경합니다.

| 실험 | chunk_size | chunk_overlap |  k |
| -- | ---------: | ------------: | -: |
| A  |       1000 |           100 |  3 |
| B  |       1000 |           100 |  5 |
| C  |       1000 |           100 |  7 |

## 평가 지표

RAGAS를 사용하여 다음 지표를 평가합니다.

| 지표                | 의미                         |
| ----------------- | -------------------------- |
| faithfulness      | 답변이 검색된 context에 근거하는지 평가  |
| answer_relevancy  | 답변이 질문과 관련 있는지 평가          |
| context_precision | 검색된 context 중 유용한 문서 비율 평가 |
| context_recall    | 필요한 context를 충분히 검색했는지 평가  |

## 최종 목표

실험 결과를 바탕으로 현재 문서에 가장 적합한 RAG 설정을 찾고, 그 이유를 분석합니다.

예시 결론:

```text
chunk_size=1000, chunk_overlap=100, k=3 설정이 가장 안정적이었다.
chunk_size=500은 검색 정밀도는 높았지만 문맥이 부족했고,
chunk_size=1500은 문맥은 풍부했지만 불필요한 정보가 섞여 precision이 낮아졌다.
```
