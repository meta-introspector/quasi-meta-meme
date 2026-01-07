# A Concise guide for the AWS Setup

**ID:** 962720
**Created At:** 2025-01-31T02:53:46+00:00
**Source:** https://codeberg.org/introspector/SOLFUNMEME/issues/90

---

**AWS Agent Deployment Guide**

## **1. Connect to the Server**

1. Set the AWS region:
   ```bash
   export AWS_REGION=us-east-1
   export AWS_DEFAULT_REGION=us-east-1
   ```
2. Find your instance ID (replace with your own ID) and start an SSM session:
   ```bash
   aws ssm start-session --target <instance-id>
   ```
3. Switch to root user and navigate to agent directory:
   ```bash
   sudo su -
   cd /opt/agent/
   ```

## **2. Verify Environment and Repository**

1. Check the current Git branch:
   ```bash
   git branch
   ```
   - Expected output: `* feature/systemd-parameters`
2. List running Docker containers:
   ```bash
   docker ps
   ```
3. (Optional) Install and record debugging sessions:
   ```bash
   apt install asciinema
   asciinema rec debug1.cast
   ```

## **3. Update and Configure the Agent**

1. View user data:
   ```bash
   cat /var/lib/cloud/instances/<instance-id>/user-data.txt
   ```
2. Clone repository if not already present:
   ```bash
   if [ ! -d "/opt/agent/" ]; then
     git clone https://github.com/meta-introspector/cloud-deployment-eliza/ "/opt/agent/"
   fi
   ```
3. Fetch the latest updates:
   ```bash
   cd /opt/agent/ || exit 1
   git stash
   git fetch --all
   git checkout --track --force "origin/feature/systemd-parameters"
   ```
4. Run the agent setup script:
   ```bash
   bash -x /opt/agent/rundocker.sh
   ```
5. Ensure sensitive information remains private:
   ```bash
   cat /var/run/agent/secrets/env
   ```

## **4. Set AWS Parameters**

1. Update parameters in AWS SSM:
   ```bash
   export AGENT_IMAGE=h4ckermike/arm64-tokenizers:feature-arm64
   export TOKENIZER_IMAGE=h4ckermike/elizaos-eliza:feature-arm64_fastembed

   aws ssm put-parameter --name "tine_agent_agent_image" --value "${AGENT_IMAGE}" --type String --overwrite
   aws ssm put-parameter --name "tine_agent_tokenizer_image" --value "${TOKENIZER_IMAGE}" --type String --overwrite
   aws ssm put-parameter --name "tine_agent_twitter_email" --value "${TWITTER_EMAIL}" --type String --overwrite
   aws ssm put-parameter --name "tine_agent_twitter_username" --value "${TWITTER_USERNAME}" --type String --overwrite
   aws ssm put-parameter --name "tine_agent_twitter_password" --value "${TWITTER_PASSWORD}" --type String --overwrite
   aws ssm put-parameter --name "tine_agent_groq_key" --value "${GROQ_API_KEY}" --type String --overwrite
   ```
2. Run the secrets setup script:
   ```bash
   bash ./get_secrets.sh
   cat /var/run/agent/secrets/env
   ```

## **5. Debugging and Systemd Setup**

1. Debug systemd unit files:
   ```bash
   Edit /etc/systemd/system.conf and set LogLevel=debug.
   ```
2. Example systemd parameters setup:
   ```ini
   EnvironmentFile=/etc/.progconf
   ExecStart=/usr/bin/prog ${ARG1} ${ARG2}
   ```

## **6. Running the Agent Docker Container**

1. Start an AWS SSM session:
   ```bash
   aws ssm start-session --target <instance-id> --region us-east-1
   ```
2. Run the Docker container:
   ```bash
   /usr/bin/docker run -p 3000:3000 \
     -v tokenizer:/app/node_modules/@anush008/tokenizers/ \
     -v tokenizer:/app/node_modules/fastembed/node_modules/.pnpm/@anush008+tokenizers@https+++codeload.github.com+meta-introspector+arm64-tokenizers+tar.gz+98_s2457qj3pe4ojcbckddasgzfvu/node_modules/@anush008/ \
     --mount type=bind,source=/opt/agent,target=/opt/agent \
     --mount type=bind,source=/opt/agent/characters/,target=/app/agent/characters/ \
     --mount type=bind,source=/opt/agent/characters/eliza.character.json,target=/app/agent/characters/eliza.character.json \
     --env-file /var/run/agent/secrets/env \
     --rm --name "agent-docker.service" \
     --entrypoint /opt/agent/docker-entrypoint-strace2.sh ${AGENT_IMAGE}
   ```

## **7. Additional References**

- [Agent Terraform Repository](https://github.com/jmikedupont2/ai-agent-terraform/tree/feature/codebuild)
- [Asciinema Recording](https://asciinema.org/a/ngq4pHltdwcBQqroAAzlXphWz)

