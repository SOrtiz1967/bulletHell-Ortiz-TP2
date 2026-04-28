## 📚 Fuentes y Referencias
* **Documentación Oficial:** Documentacion oficial de godot para aprender a aprovechar las herramientas y buscar alternativas a cosas que no estan en otros lenguajes.
* **Comunidad Poli:** mas alla de las preguntas que me respondieron tanto el profesor como compañeros miusmos, ver sus problemas que muchos los tuve yo tambien me ayudaron a soluionarlos mas facil, asi como aprender de ellos y su forma de usar la herramienta, mas alla de solo el discord. muchos tiempos muertos en el poli haciendo el juego conte con la ayuda mutua de compañeros.
* **YouTube: varios videos, tomando cosas de varios y juntandolos a mi conveniencia. https://www.youtube.com/watch?v=Z2TaFnN7cdU, https://www.youtube.com/watch?v=GXoSBKpM0lA,https://www.youtube.com/watch?v=miEi6IWvVgw. entre otros.
* **foros: foros de reddit y hasta publicaciones en stack overflow a la antigua me ayudaron
# Testeabilidad y Diseño

A la hora de armar la lógica del juego, los niveles y su funcionamiento, ya tenía algo pensado porque ya había diseñado a los enemigos, pero con los primeros niveles y las pruebas fueron surgiendo cambios de diseño.

## Cambios de Diseño Significativos
El ejemplo más claro son los **cactus**: 
* Originalmente eran más rápidos y no te curaban.
* Un juego de varios niveles con mobs combinados como había pensado era inviable (demasiado difícil).
* **Solución:** Empecé a regular velocidades y agregué que te curen cuando los matas. 
* **Decisión:** Creo que esta es la mejor cualidad del juego; lo hace un poco más fácil pero no te regala nada.
* **Nota:** Barajé la posibilidad de que no todos te curen (50/50), pero por una cuestión de tiempo y enfoque en otras cosas no seguí con eso.

## Progresión y Niveles
Los niveles no tienen muchas vueltas de tuerca; traté de hacerlos **progresivos** para que el usuario le pueda agarrar la mano y se vaya poniendo más difícil. 
* No llega a ser muy complicado, aunque en algunas versiones es impasable.
* **Observación en usuarios:** Al principio les costaba adaptarse a la mecánica de disparar a donde apuntas, pero después de varios minutos mejoraban y peleaban los niveles finales.

---

## Problemas Surgidos y Soluciones

### 1. El Boss Final y la Vida
* **Problema:** Llegar al boss con uno o dos corazones volvía el nivel muy difícil porque no se podía recuperar vida.
* **Solución inicial:** Restablecer la vida del jugador en el nivel final.
* **Solución definitiva:** Al seguir siendo muy difícil, agregué **spawn de cactus** para recuperar vida. Quería evitar nerfear al boss para que sea desafiante y realmente te trabes; sino sería un nivel sin más.

### 2. Spammers en el medio del mapa
* **Problema:** Eran muy difíciles de esquivar y matar. Por el patrón de disparo es complicado si el spawn es random y justo te aparece en el medio.

### 3. Patrones de proyectiles
* **Variables ajustadas:** Los escopetazos del boss, la velocidad de las ráfagas de las torretas. Estas variables se fueron ajustando jugando al juego.

### 4. El orden de los niveles y su maquetado
Hay niveles que te dan aire o te ayudan, sin regalarte nada:
* **Horda de cactus:** Parece difícil pero te salva la vida y te da la oportunidad de curarte si estás tocado.
* **Nivel de spammers al hilo:** Es una especie de respiro de cactus para enfocarse en esquivar balas.
* **Nivel de inicio:** El hecho de que arranque con cactus tampoco es casualidad.
