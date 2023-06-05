# GitAction

## All steps

### Step1: Create Go Module

```shell
go mod init github.com/xcheng85/gitaction-test-golang

```

### Step2: Install external deps (structural logging)
```shell
go get -u go.uber.org/zap
go mod tidy #download missing deps
sudo apt install golang-golang-x-tools
goimports -w .
go build .
go run .

```

### Step3: Muti-stage dockerfile

### Step4: Github workflow
```shell
mkdir -p .github && cd .github/ && mkdir -p workflows && touch main.yaml && cd ../

```

### Step5: Create Repository Secret
1. Docker username
2. Docker password
and reference it as env

### Step6: Commit github action yaml
```shell
git status -s
git add .
git commit -m ""
git push origin main
```

### Step7: custom tag
mkdir -p build && touch ./build/git_update.sh


## Hightlights

### go get vs go mod download

Run docker login -u $DOCKER_USER -p $DOCKER_PASSWORD
WARNING! Using -*** the CLI is insecure. Use --password-stdin.
