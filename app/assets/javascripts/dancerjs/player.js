(function () {

  // var track = location.search.split('=')[1];
  var track = document.body.getAttribute('data-track-id');

  var
    AUDIO_FILE        = 'https://api.soundcloud.com/tracks/' + track + '/stream?client_id=b45b1aa10f1ac2941910a7f0d10f8e28',
    PARTICLE_COUNT    = 250,
    MAX_PARTICLE_SIZE = 12,
    MIN_PARTICLE_SIZE = 2,
    GROWTH_RATE       = 5,
    DECAY_RATE        = 0.5,

    BEAM_RATE         = 0.5,
    BEAM_COUNT        = 20,

    GROWTH_VECTOR = new THREE.Vector3( GROWTH_RATE, GROWTH_RATE, GROWTH_RATE ),
    DECAY_VECTOR  = new THREE.Vector3( DECAY_RATE, DECAY_RATE, DECAY_RATE ),
    beamGroup     = new THREE.Object3D(),
    particles     = group.children,
    colors        = [ 0xaaee22, 0x04dbe5, 0xff0077, 0xffb412, 0xf6c83d ],
    t, dancer, beat;

  /*
   * Dancer.js magic
   */


  dancer = new Dancer( AUDIO_FILE, [ 'ogg', 'mp3' ] );
  beat = dancer.createBeat({
    onBeat: function () {
      var i;
      if ( particles[ 0 ].scale.x > MAX_PARTICLE_SIZE ) {
        decay();
      } else {
        for ( i = PARTICLE_COUNT; i--; ) {
          particles[ i ].scale.addSelf( GROWTH_VECTOR );
        }
      }
      if ( !beamGroup.children[ 0 ].visible ) {
        for ( i = BEAM_COUNT; i--; ) {
          beamGroup.children[ i ].visible = true;
        }
      }
    },
    offBeat: decay
  });

  dancer.onceAt( 0, function () {
    beat.on();
  }).onceAt( 8.2, function () {
    scene.add( beamGroup );
  }).after( 8.2, function () {
    beamGroup.rotation.x += BEAM_RATE;
    beamGroup.rotation.y += BEAM_RATE;
  }).onceAt( 50, function () {
    changeParticleMat( 'white' );
  }).onceAt( 66.5, function () {
    changeParticleMat( 'pink' );
  }).onceAt( 75, function () {
    changeParticleMat();
  });

  Dancer.isSupported() || loaded();
  !dancer.isLoaded() ? dancer.bind( 'loaded', loaded ) : loaded();

  /*
   * Three.js Setup
   */

  function on () {
    for ( var i = PARTICLE_COUNT; i--; ) {
      particle = new THREE.Particle( newParticleMat() );
      particle.position.x = Math.random() * 2000 - 1000;
      particle.position.y = Math.random() * 2000 - 1000;
      particle.position.z = Math.random() * 2000 - 1000;
      particle.scale.x = particle.scale.y = Math.random() * 10 + 5;
      group.add( particle );
    }
    scene.add( group );

    // Beam idea from http://www.airtightinteractive.com/demos/js/nebula/
    var
      beamGeometry = new THREE.PlaneGeometry( 5000, 50, 1, 1 ),
      beamMaterial, beam;

    for ( i = BEAM_COUNT; i--; ) {
      beamMaterial = new THREE.MeshBasicMaterial({
        opacity: 0.5,
        blending: THREE.AdditiveBlending,
        depthTest: false,
        color: colors[ ~~( Math.random() * 5 )]
      });
      beam = new THREE.Mesh( beamGeometry, beamMaterial );
      beam.doubleSided = true;
      beam.rotation.x = Math.random() * Math.PI;
      beam.rotation.y = Math.random() * Math.PI;
      beam.rotation.z = Math.random() * Math.PI;
      beamGroup.add( beam );
    }
  }

  function decay () {
    if ( beamGroup.children[ 0 ].visible ) {
      for ( i = BEAM_COUNT; i--; ) {
        beamGroup.children[ i ].visible = false;
      }
    }

    for ( var i = PARTICLE_COUNT; i--; ) {
      if ( particles[i].scale.x - DECAY_RATE > MIN_PARTICLE_SIZE ) {
        particles[ i ].scale.subSelf( DECAY_VECTOR );
      }
    }
  }

  function changeParticleMat ( color ) {
    var mat = newParticleMat( color );
    for ( var i = PARTICLE_COUNT; i--; ) {
      if ( !color ) {
        mat = newParticleMat();
      }
      particles[ i ].material = mat;
    }
  }

  function newParticleMat( color ) {
    var
      sprites = [ 'pink', 'orange', 'yellow', 'blue', 'green' ],
      sprite = color || sprites[ ~~( Math.random() * 5 )];

    return new THREE.ParticleBasicMaterial({
      blending: THREE.AdditiveBlending,
      size: MIN_PARTICLE_SIZE,
      map: THREE.ImageUtils.loadTexture('/assets/dancerjs/particle_' + sprite + '.png'),
      vertexColor: 0xFFFFFF
    });
  }

  function loaded () {
    dancer.play();
  }

  on();

  // For debugging
  window.dancer = dancer;

})();
