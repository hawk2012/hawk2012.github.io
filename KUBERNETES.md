[ГЛАВНАЯ](README.md) | [ОТВЕТЫ](DEVOPS_QA.md) | [KUBERNETES](KUBERNETES.md) | [MULTICAST](MULTICAST.md)

# 🧠 ШПАРГАЛКА ПО KUBERNETES

## 📚 Содержание

### 🔹 1. ОСНОВНЫЕ ПОНЯТИЯ
- [Что такое Kubernetes?](#-что-такое-kubernetes)
- [Какие задачи решает Kubernetes?](#-какие-задачи-решает-kubernetes)
- [Что такое Pod?](#-что-такое-pod)
- [Что такое Node?](#-что-такое-node)
- [Что такое Cluster?](#-что-такое-cluster)

### 🔹 2. АРХИТЕКТУРА КЛАСТЕРА
- [Какова архитектура кластера Kubernetes?](#-какова-архитектура-кластера-kubernetes)

### 🔹 3. ОБЪЕКТЫ И РЕСУРСЫ
- [Какие основные типы ресурсов в Kubernetes?](#-какие-основные-типы-ресурсов-в-kubernetes)
- [Что такое Deployment?](#-что-такое-deployment)
- [Что такое ReplicaSet?](#-что-такое-replicaset)
- [Что такое StatefulSet?](#-что-такое-statefulset)
- [Что такое DaemonSet?](#-что-такое-daemonset)
- [Что такое Job и CronJob?](#-что-такое-job-и-cronjob)
- [Что такое Service?](#-что-такое-service)
- [Что такое Ingress?](#-что-такое-ingress)
- [Что такое ConfigMap?](#-что-такое-configmap)
- [Что такое Secret?](#-что-такое-secret)
- [Что такое PersistentVolume (PV)?](#-что-такое-persistentvolume-pv)
- [Что такое PersistentVolumeClaim (PVC)?](#-что-такое-persistentvolumeclaim-pvc)
- [Что такое StorageClass?](#-что-такое-storageclass)

### 🔹 4. СЕТИ
- [Как устроена сеть в Kubernetes?](#-как-устроена-сеть-в-kubernetes)
- [Какие плагины сетей используются в Kubernetes?](#-какие-плагины-сетей-используются-в-kubernetes)
- [Что такое CNI?](#-что-такое-cni)
- [Как работает kube-proxy?](#-как-работает-kube-proxy)

### 🔹 5. БЕЗОПАСНОСТЬ
- [Какие механизмы безопасности есть в Kubernetes?](#-какие-механизмы-безопасности-есть-в-kubernetes)

### 🔹 6. ЖИЗНЕННЫЙ ЦИКЛ КОНТЕЙНЕРОВ
- [Какие есть этапы жизненного цикла контейнера?](#-какие-есть-этапы-жизненного-цикла-контейнера)
- [Что такое ReadinessProbe и LivenessProbe?](#-что-такое-readinessprobe-и-livenessprobe)
- [Что такое Init Containers?](#-что-такое-init-containers)

### 🔹 7. ПЛАНИРОВАНИЕ И НАЗНАЧЕНИЕ
- [Что такое Taint и Toleration?](#-что-такое-taint-и-toleration)
- [Что такое NodeSelector и Affinity?](#-что-такое-nodeselector-и-affinity)

### 🔹 8. ПОДДЕРЖКА ОКРУЖЕНИЯ
- [Что такое Helm?](#-что-такое-helm)
- [Что такое Operator?](#-что-такое-operator)

### 🔹 9. ПРОИЗВОДИТЕЛЬНОСТЬ И МОНИТОРИНГ
- [Как мониторят кластеры?](#-как-мониторят-кластеры)
- [Что такое Horizontal Pod Autoscaler (HPA)?](#-что-такое-horizontal-pod-autoscaler-hpa)
- [Что такое Vertical Pod Autoscaler (VPA)?](#-что-такое-vertical-pod-autoscaler-vpa)

### 🔹 10. РАЗВЁРТЫВАНИЕ И ОБНОВЛЕНИЕ
- [Какие стратегии обновления существуют в Deployment?](#-какие-стратегии-обновления-существуют-в-deployment)
- [Как проверить историю обновлений?](#-как-проверить-историю-обновлений)
- [Как выполнить откат?](#-как-выполнить-откат)

### 🔹 11. ПРАКТИЧЕСКИЕ КОМАНДЫ
- [Практические команды](#-🔹-11-практические-команды)

### 🔹 12. ЭКЗАМЕНЫ И СЕРТИФИКАЦИИ
- [Какие есть сертификации от CNCF?](#-какие-есть-сертификации-от-cncf)

### 🔹 13. ЧАСТО ЗАДАВАЕМЫЕ ВОПРОСЫ
- [Чем отличаются Deployment и StatefulSet?](#-чем-отличаются-deployment-и-statefulset)
- [Чем отличаются ConfigMap и Secret?](#-чем-отличаются-configmap-и-secret)
- [Что такое Headless Service?](#-что-такое-headless-service)
- [Что такое DaemonSet и когда его использовать?](#-что-такое-daemonset-и-когда-его-использовать)
- [Что такое Taint и Toleration? Зачем они?](#-что-такое-taint-и-toleration-зачем-они)
- [Как работают readinessProbe и livenessProbe?](#-как-работают-readinessprobe-и-livenessprobe)

### 🔹 14. BEST PRACTICES
- [Best practices](#-🔹-14-best-practices)

### 🔹 15. ПОЛЕЗНЫЕ ИНСТРУМЕНТЫ
- [Полезные инструменты](#-🔹-15-полезные-инструменты)

---

## 🔹 1. ОСНОВНЫЕ ПОНЯТИЯ

### ✅ Что такое Kubernetes?
- Система оркестрации контейнеров.
- Управляет жизненным циклом контейнеров: развертывание, масштабирование, самовосстановление и т.д.
- Поддерживает автоматизированное развертывание и управление микросервисами.

### ✅ Какие задачи решает Kubernetes?
- Автоматическое развертывание приложений
- Масштабируемость (горизонтальная/вертикальная)
- Самовосстановление (перезапуск неудачных контейнеров)
- Балансировка нагрузки
- Обновления с нулевым временем простоя
- Хранение данных (Persistent Volumes)

### ✅ Что такое Pod?
- Наименьшая единица в Kubernetes.
- Группа одного или нескольких контейнеров, работающих вместе на одном узле.
- Имеют общий сетевой namespace и storage volume.

### ✅ Что такое Node?
- Физическая или виртуальная машина, где запускаются контейнеры.
- Работают процессы kubelet, kube-proxy, container runtime (Docker, containerd).

### ✅ Что такое Cluster?
- Группа узлов (Nodes), управляемых Control Plane.
- Может состоять из master-узла(ов) и worker-узлов.

---

## 🔹 2. АРХИТЕКТУРА КЛАСТЕРА

### ✅ Какова архитектура кластера Kubernetes?

**Control Plane (Master node):**
- **kube-apiserver**: точка входа для всех команд
- **etcd**: распределенное хранилище состояния кластера
- **kube-scheduler**: назначает Pods на подходящий Node
- **kube-controller-manager**: следит за желаемым состоянием кластера
- **cloud-controller-manager**: взаимодействует с облачным провайдером

**Worker Nodes:**
- **kubelet**: коммуникация с API сервером, управление контейнерами
- **kube-proxy**: обеспечивает сетевую связь между Pods
- **Container Runtime**: запуск и остановка контейнеров (containerd, Docker, CRI-O)

---

## 🔹 3. ОБЪЕКТЫ И РЕСУРСЫ

### ✅ Какие основные типы ресурсов в Kubernetes?
- **Pod**
- **Deployment**
- **Service**
- **StatefulSet**
- **DaemonSet**
- **Job / CronJob**
- **ConfigMap**
- **Secret**
- **PersistentVolume (PV)**
- **PersistentVolumeClaim (PVC)**
- **Ingress**
- **Namespace**
- **Role / RoleBinding / ClusterRole / ClusterRoleBinding**
- **CustomResourceDefinition (CRD)**

### ✅ Что такое Deployment?
- Управляет реплицированными наборами Pods.
- Предоставляет механизмы обновлений (Rolling Update), откатов (Rollback).
- Декларативный способ управления приложениями.

### ✅ Что такое ReplicaSet?
- Обеспечивает наличие заданного количества Pod-копий.
- Устарел, сейчас используется через Deployment.

### ✅ Что такое StatefulSet?
- Используется для stateful-приложений (например, базы данных).
- Обеспечивает уникальность и стабильность Pod'ов.

### ✅ Что такое DaemonSet?
- Запускает один Pod на каждом узле (или на выбранных узлах).
- Примеры: сбор логов, мониторинг.

### ✅ Что такое Job и CronJob?
- **Job**: запускает Pod до успешного завершения.
- **CronJob**: запускает Job по расписанию (cron-like).

### ✅ Что такое Service?
- Абстракция над группой Pods, предоставляющая доступ к ним.
- Типы:
  - ClusterIP (по умолчанию)
  - NodePort
  - LoadBalancer
  - ExternalName

### ✅ Что такое Ingress?
- Объект для маршрутизации HTTP(S) трафика внутрь кластера.
- Требует контроллер (например, NGINX Ingress Controller).

### ✅ Что такое ConfigMap?
- Хранение конфигурационных данных (небезопасные данные).
- Передается в контейнер как переменная окружения или файл.

### ✅ Что такое Secret?
- Хранение чувствительных данных (пароли, ключи, сертификаты).
- По умолчанию хранится в etcd в виде base64, но не шифруется без дополнительных мер.

### ✅ Что такое PersistentVolume (PV)?
- Физический ресурс хранения данных вне жизненного цикла Pod.

### ✅ Что такое PersistentVolumeClaim (PVC)?
- Заявка пользователя на использование PV.
- Связывается с подходящим PV через класс хранилища (StorageClass).

### ✅ Что такое StorageClass?
- Определяет типы хранилищ и параметры динамического выделения томов.

---

## 🔹 4. СЕТИ

### ✅ Как устроена сеть в Kubernetes?
- Все Pods могут общаться друг с другом без NAT.
- Все узлы могут общаться с любыми Pods без NAT.
- IP у каждого Pod'а — единое пространство.

### ✅ Какие плагины сетей используются в Kubernetes?
- Calico
- Flannel
- Weave Net
- Cilium
- Kube-router
- Contiv

### ✅ Что такое CNI?
- Container Network Interface — стандарт для подключения контейнеров к сети.

### ✅ Как работает kube-proxy?
- Отвечает за балансировку нагрузки и маршрутизацию трафика к сервисам.
- Использует iptables/IPVS.

---

## 🔹 5. БЕЗОПАСНОСТЬ

### ✅ Какие механизмы безопасности есть в Kubernetes?

#### 🔐 RBAC (Role-Based Access Control)
- Управление доступом через:
  - Role / ClusterRole
  - RoleBinding / ClusterRoleBinding

#### 🔒 Network Policies
- Ограничивают сетевые соединения между Pod'ами.
- Реализуются через CNI-плагины.

#### 🔐 Pod Security Admission (PSA)
- Заменил PodSecurityPolicy (PSP).
- Правила ограничения запуска привилегированных контейнеров, mount'а root FS и т.д.

#### 🔒 Secrets Management
- Хранение секретов в etcd (лучше шифровать).
- Альтернативы: HashiCorp Vault, Sealed Secrets.

#### 🔐 TLS и сертификаты
- Компоненты Kubernetes используют TLS для безопасной связи.
- Certificates API позволяет генерировать сертификаты.

#### 🔐 ImagePolicyWebhook
- Позволяет блокировать загрузку образов без подписи.

---

## 🔹 6. ЖИЗНЕННЫЙ ЦИКЛ КОНТЕЙНЕРОВ

### ✅ Какие есть этапы жизненного цикла контейнера?
- **PostStart**: вызывается сразу после создания контейнера.
- **PreStop**: вызывается перед удалением контейнера.

### ✅ Что такое ReadinessProbe и LivenessProbe?
- **livenessProbe**: определяет, жив ли контейнер.
- **readinessProbe**: определяет, готов ли контейнер принимать трафик.

### ✅ Что такое Init Containers?
- Контейнеры, выполняемые до основного контейнера.
- Используются для подготовки среды (ожидание БД, миграции и т.д.).

---

## 🔹 7. ПЛАНИРОВАНИЕ И НАЗНАЧЕНИЕ

### ✅ Что такое Taint и Toleration?
- **Taint**: "пометка" узла, чтобы запретить запуск на нем определенных Pod'ов.
- **Toleration**: разрешение Pod'у запускаться на помеченном узле.

### ✅ Что такое NodeSelector и Affinity?
- **NodeSelector**: выбор узла по label.
- **Affinity**: более гибкий способ выбора узла (Node Affinity, Pod Affinity/Anti-Affinity).

---

## 🔹 8. ПОДДЕРЖКА ОКРУЖЕНИЯ

### ✅ Что такое Helm?
- Package manager для Kubernetes.
- Пакеты называются Charts.
- Упрощает развертывание сложных приложений.

### ✅ Что такое Operator?
- Метод автоматизации управления stateful-приложениями.
- Инкапсулирует знания экспертов по управлению приложением.

---

## 🔹 9. ПРОИЗВОДИТЕЛЬНОСТЬ И МОНИТОРИНГ

### ✅ Как мониторят кластеры?
- Prometheus + Grafana
- ELK Stack / Fluentd + Elasticsearch + Kibana
- Loki + Promtail
- Datadog, New Relic, AWS CloudWatch

### ✅ Что такое Horizontal Pod Autoscaler (HPA)?
- Автоматически масштабирует количество Pod'ов по метрикам (CPU, Memory, custom metrics).

### ✅ Что такое Vertical Pod Autoscaler (VPA)?
- Автоматически регулирует ресурсы CPU/Memory для Pod'ов.

---

## 🔹 10. РАЗВЁРТЫВАНИЕ И ОБНОВЛЕНИЕ

### ✅ Какие стратегии обновления существуют в Deployment?
- **RollingUpdate** (по умолчанию)
- **Recreate**

### ✅ Как проверить историю обновлений?
```bash
kubectl rollout history deployment <name>
```

### ✅ Как выполнить откат?
```bash
kubectl rollout undo deployment <name> --to-revision=<revision>
```

---

## 🔹 11. ПРАКТИЧЕСКИЕ КОМАНДЫ

| Задача | Команда |
|-------|--------|
| Посмотреть все pods | `kubectl get pods` |
| Посмотреть все pods во всех namespaces | `kubectl get pods --all-namespaces` |
| Посмотреть описание pod | `kubectl describe pod <pod-name>` |
| Получить логи pod | `kubectl logs <pod-name>` |
| Выполнить команду внутри pod | `kubectl exec -it <pod-name> -- bash` |
| Проброс порта | `kubectl port-forward <pod-name> 8080:80` |
| Применить манифест | `kubectl apply -f file.yaml` |
| Удалить ресурс | `kubectl delete -f file.yaml` |
| Получить информацию о кластере | `kubectl cluster-info` |
| Посмотреть config | `kubectl config view` |

---

## 🔹 12. ЭКЗАМЕНЫ И СЕРТИФИКАЦИИ

### ✅ Какие есть сертификации от CNCF?
- **CKA** – Certified Kubernetes Administrator
- **CKAD** – Certified Kubernetes Application Developer
- **CKS** – Certified Kubernetes Security Specialist

---

## 🔹 13. ЧАСТО ЗАДАВАЕМЫЕ ВОПРОСЫ

### ❓ Чем отличаются Deployment и StatefulSet?
- Deployment — для stateless приложений, StatefulSet — для stateful.
- StatefulSet гарантирует уникальность и порядок Pod'ов.

### ❓ Чем отличаются ConfigMap и Secret?
- ConfigMap — для открытых данных, Secret — для чувствительных.
- Secret кодируется в base64, но не шифруется по умолчанию.

### ❓ Что такое Headless Service?
- Не имеет ClusterIP, используется для прямого обращения к Pod'ам.

### ❓ Что такое DaemonSet и когда его использовать?
- Для запуска одного Pod'а на каждом узле, например, для логирования или мониторинга.

### ❓ Что такое Taint и Toleration? Зачем они?
- Управляют допустимостью запуска Pod'ов на узлах.

### ❓ Как работают readinessProbe и livenessProbe?
- readinessProbe — для проверки готовности Pod'а к работе.
- livenessProbe — для перезапуска "мертвых" Pod'ов.

---

## 🔹 14. BEST PRACTICES

- Использовать Namespaces для разделения сред.
- Использовать минимальные образы контейнеров.
- Указывать requests и limits для ресурсов.
- Использовать Rolling Updates.
- Хранить манифесты в Git (GitOps).
- Использовать RBAC и Network Policies для безопасности.
- Использовать Helm или Kustomize для управления конфигами.

---

## 🔹 15. ПОЛЕЗНЫЕ ИНСТРУМЕНТЫ

- **kubeadm** – установка кластера
- **kops** – продвинутый инструмент для создания кластеров
- **Helm** – управление пакетами
- **Kustomize** – кастомизация манифестов
- **Lens** – GUI-интерфейс для работы с кластерами
- **kubectl debug** – отладка проблемных Pod'ов
