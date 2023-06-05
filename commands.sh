tkn hub install task git-clone
tkn hub install task docker-build

tkn clustertask ls

kubectl apply -f https://raw.githubusercontent.com/tektoncd/catalog/main/task/git-clone/0.9/git-clone.yaml

kubectl apply -f tasks.yaml
kubectl apply -f pvc.yaml
kubectl apply -f pipeline.yaml

tkn pipeline start cd-pipeline \
    -p repo-url="https://github.com/yahya-skillup/tax_calculator.git" \
    -p branch=main \
    -p app-name=tax-calculator \
    -p build-image=image-registry.openshift-image-registry.svc:5000/$SN_ICR_NAMESPACE/tax-calculator \
    -w name=pipeline-workspace,claimName=pipelinerun-pvc \
    --showlog

tkn pipelinerun ls

tkn pipelinerun logs --last

kubectl get all -l app=tax-calculator



IBMCLOUD_API_KEY=THE_KEY
ibmcloud login --apikey $IBMCLOUD_API_KEY
ibmcloud target -g production
ibmcloud ce project current | grep ID | awk '{split($2, a, ":"); print a[1]}'
ibmcloud ce project select --id d8db2fbf-REMAINING_ID
ibmcloud ce project current
