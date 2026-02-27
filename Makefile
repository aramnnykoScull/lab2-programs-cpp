# Компилятор и флаги
CXX      := g++
CXXFLAGS := -std=c++17 -Wall -Wextra -Werror

# Директории
SRC_DIR := src
OBJ_DIR := obj
BIN_DIR := bin

# Автоматическое определение исходных файлов
COMMON_SRC   := $(SRC_DIR)/point_all.cpp
PROGRAM_SRCS := $(wildcard $(SRC_DIR)/point[0-9].cpp)

# Объектные файлы
COMMON_OBJ   := $(OBJ_DIR)/point_all.o
PROGRAM_OBJS := $(PROGRAM_SRCS:$(SRC_DIR)/%.cpp=$(OBJ_DIR)/%.o)

# Исполняемые файлы
TARGETS := $(PROGRAM_SRCS:$(SRC_DIR)/%.cpp=$(BIN_DIR)/%)

# Основные цели
.PHONY: all clean clean-report rebuild help run_point1 run_point2 run_point3 run_all report

all: $(TARGETS)

# Сборка исполняемых файлов: каждый зависит от своего объектного и общего объектного
$(BIN_DIR)/%: $(OBJ_DIR)/%.o $(COMMON_OBJ)
	@mkdir -p $(BIN_DIR)
	$(CXX) $^ -o $@

# Компиляция объектных файлов программ
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp $(SRC_DIR)/point_all.h
	@mkdir -p $(OBJ_DIR)
	$(CXX) $(CXXFLAGS) -c $< -o $@

# Компиляция общего объектного файла
$(COMMON_OBJ): $(COMMON_SRC) $(SRC_DIR)/point_all.h
	@mkdir -p $(OBJ_DIR)
	$(CXX) $(CXXFLAGS) -c $(COMMON_SRC) -o $(COMMON_OBJ)

# Запуск отдельных программ
run_point1: $(BIN_DIR)/point1
	@echo "=== Запуск программы расчёта площади квадрата ==="
	@./$(BIN_DIR)/point1

run_point2: $(BIN_DIR)/point2
	@echo "=== Запуск программы расчёта объёма параллелепипеда ==="
	@./$(BIN_DIR)/point2

run_point3: $(BIN_DIR)/point3
	@echo "=== Запуск программы расчёта расстояния ==="
	@./$(BIN_DIR)/point3

# Запуск всех программ по очереди
run_all: $(TARGETS)
	@echo "=== Запуск всех программ ==="
	@for prog in $(TARGETS); do \
		echo "--- Запуск $$(basename $$prog) ---"; \
		./$$prog; \
		echo ""; \
	done

# (Опционально) Сборка отчёта, если установлен XeLaTeX
report: report/lab2.pdf

report/lab2.pdf: report/lab2.tex
	cd report && xelatex lab2.tex && xelatex lab2.tex   # два прохода для корректных ссылок

# Очистка временных файлов LaTeX
clean-report:
	if [ -d report ]; then cd report && rm -f *.aux *.log *.out *.toc *.synctex.gz *.fls *.fdb_latexmk; fi

# Очистка всего проекта
clean: clean-report
	rm -rf $(OBJ_DIR) $(BIN_DIR)

# Полная пересборка
rebuild: clean all

# Справка
help:
	@echo "Доступные цели:"
	@echo "  all          - сборка всех программ (по умолчанию)"
	@echo "  run_point1   - запуск программы расчёта площади квадрата"
	@echo "  run_point2   - запуск программы расчёта объёма параллелепипеда"
	@echo "  run_point3   - запуск программы расчёта расстояния"
	@echo "  run_all      - запуск всех программ по очереди"
	@echo "  report       - (опционально) сборка отчёта из LaTeX (требуется XeLaTeX)"
	@echo "  clean        - удаление объектных и исполняемых файлов"
	@echo "  clean-report - удаление временных файлов LaTeX"
	@echo "  rebuild      - полная пересборка (clean + all)"
	@echo "  help         - показать эту справку"