/** 
 * Jenkins configuration
 *
 * @see https://github.com/jenkinsci/docker
 */

import jenkins.model.*
Jenkins.instance.setNumExecutors(5)