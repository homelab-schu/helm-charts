
{{/*
Expand the name of the chart.
*/}}
{{- define "prowlarr.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by DNS).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "prowlarr.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end -}}

{{/*
Create chart-level resource labels.
*/}}
{{- define "prowlarr.labels" -}}
helm.sh/chart: {{ include "prowlarr.chart" . }}
{{ include "prowlarr.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Create the name of the PVC.
*/}}
{{- define "prowlarr.pvcName" -}}
{{- if .Values.persistence.existingClaim }}
{{- .Values.persistence.existingClaim }}
{{- else }}
{{ include "prowlarr.fullname" . }}-config
{{- end }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "prowlarr.selectorLabels" -}}
app.kubernetes.io/name: {{ include "prowlarr.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "prowlarr.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "prowlarr.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end -}}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "prowlarr.imagePullSecrets" -}}
{{- if .Values.imagePullSecrets }}
{{- .Values.imagePullSecrets }}
{{- else }}
{{- default "" }}
{{- end -}}
{{- end -}}

{{/*
Return the chart version
*/}}
{{- define "prowlarr.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end -}}