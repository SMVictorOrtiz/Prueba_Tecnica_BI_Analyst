# Prueba_Tecnica_BI_Analyst

## Instrucciones para ejecutar y revisar los archivos del proyecto

Este repositorio contiene tres componentes principales:

- Archivo SQL  
- Notebook de Python  
- Dashboard de Power BI  

A continuación se describen los requisitos e instrucciones para abrir y revisar cada uno.

---

## Requisitos generales

### Software necesario
- **SQLite** o cualquier cliente SQL compatible  
- **Python 3.9+** con:
  - pandas  
  - numpy  
  - jupyter  
- **Power BI Desktop** o acceso a Power BI Service  

### Datasets requeridos (ubicados en la carpeta `data/`)
- `olist_orders_dataset.csv`
- `olist_order_items_dataset.csv`
- `olist_order_payments_dataset.csv`
- `olist_order_reviews_dataset.csv`

---

## 1. Dashboard Power BI - `parte1.pbix`

### Opción A:

1. Instalar Power BI Desktop
2. Abrir: `parte1.pbix`
3. En caso de requerirlo, actualizar las conexiones con los CSV de: https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce

### Opción B:

Ver en Power BI Service con este enlace público: https://app.powerbi.com/groups/me/reports/442afb60-e72b-4cd1-bb07-9ce71fa8f96e?ctid=a37c2367-cf18-441f-93e5-85d7db0d493d&pbi_source=linkShare&bookmarkGuid=2809a889-d221-4eef-8817-b5073fc8fdb5

---

## 2. Archivo SQL - `parte2.sql`

### Instrucciones

1. Abrir un cliente SQL como SQLite CLI, DBeaver o DB Browser.
2. Crear o cargar la base de datos:
   ```bash
   sqlite3 olist.db
3. Importar las tablas de: Brazilian E-Commerce Public Dataset by Olist (Kaggle)
https://www.kaggle.com/datasets/terencicp/e-commerce-dataset-by-olist-as-an-sqlite-database
4. Ejecutar el archivo SQLite:
    ```sql
    .read sql/parte2.sql

---

## 3. Notebook Python - 'parte3.ipynb'

### Instrucciones

1. Instalar dependencias:
    ```bash
   pip install pandas jupyter
2. Iniciar Jupyter:
    ```bash
   jupyter notebook
3. Abrir el archivo:
    ```bash
   python/parte3.ipynb
4. Verificar o actualizar las rutas a los archivos CSV en las primeras celdas según sea necesario. (Con la misma ruta de Power BI)
