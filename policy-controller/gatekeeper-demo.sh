#!/bin/bash

########################
# include the magic
########################
# instal doitlive "pip install doitlive"


alias k=kubectl


#clear
k get constrainttemplates -l="configmanagement.gke.io/configmanagement=config-management"

k describe k8sallowedrepos

# Repo
cd repo
ls -ltr
cat constraint-pod-repo.yaml
k apply -f constraint-pod-repo.yaml
k describe k8sallowedrepos
cat fail-pod-repo.yaml
k apply -f fail-pod-repo.yaml -n bd-demo
cat pass-pod-repo.yaml
k apply -f pass-pod-repo.yaml -n bd-demo
k get pods -n bd-demo
clear t

# Container limit
cd ../containerlimits
cat constraint-container-limit.yaml 
kubectl apply -f constraint-container-limit.yaml -n bd-demo
cat fail-container-limit.yaml
k apply -f fail-container-limit.yaml -n bd-demo
cat fail-container-limit.yaml 
k apply -f pass-container-limit.yaml -n bd-demo
k get pods -n bd-demo
cat pass-container-limit.yaml
clear t

# Constraint priv pod
cd ../podsecurity
cat constraint-pod-priv.yaml 
k apply -f constraint-pod-priv.yaml 
ls
cat fail-pod-priv.yaml 
k apply -f fail-pod-priv.yaml 
k apply -f pass-pod-priv.yaml
cat pass-pod-priv.yaml 
k get pods -n bd-demo
clear t

# Cleanup
k delete -f pass-pod-priv.yaml
k delete -f constraint-pod-priv.yaml
k delete -f ../containerlimits/pass-container-limit.yaml -n bd-demo
k delete -f ../containerlimits/constraint-container-limit.yaml -n bd-demo
k delete -f ../repo/pass-pod-repo.yaml -n bd-demo
k delete -f ../repo/constraint-pod-repo.yaml



